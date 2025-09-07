using CloudNative.CloudEvents;
using CloudNative.CloudEvents.SystemTextJson;
using DotPulsar;
using DotPulsar.Abstractions;
using DotPulsar.Extensions;
using ModelProductionCase.Models;
using System.Buffers;
using System.Text;
using System.Text.Json;

namespace ModelProductionCase.Services
{
  public interface IEventProducerService
  {
    Task SendItemCreatedEventAsync(Item item);
    Task SendItemUpdatedEventAsync(Item item);
    Task SendItemDeletedEventAsync(int itemId);
  }

  public class EventProducerService : IEventProducerService, IDisposable
  {
    private readonly IProducer<ReadOnlySequence<byte>> _producer;
    private readonly CloudEventFormatter _formatter;

    public EventProducerService(IConfiguration configuration)
    {
      var pulsarClient = PulsarClient.Builder()
          .ServiceUrl(new Uri(configuration.GetConnectionString("Pulsar") ?? "pulsar://localhost:6650"))
          .Build();

      _producer = pulsarClient.NewProducer()
          .Topic("model-plan.v1")
          .ProducerName("ModelProductionCaseProducer")
          .Create();

      _formatter = new JsonEventFormatter();
    }

    public async Task SendItemCreatedEventAsync(Item item)
    {
      var cloudEvent = new CloudEvent
      {
        Type = "com.modelproductioncase.item.created",
        Source = new Uri("https://modelproductioncase/items"),
        Id = Guid.NewGuid().ToString(),
        Time = DateTimeOffset.UtcNow,
        DataContentType = "application/json",
        Data = JsonSerializer.Serialize(new
        {
          Id = item.Id,
          Name = item.Name,
          Status = item.Status
        })
      };

      await SendCloudEventAsync(cloudEvent);
    }

    public async Task SendItemUpdatedEventAsync(Item item)
    {
      var cloudEvent = new CloudEvent
      {
        Type = "com.modelproductioncase.item.updated",
        Source = new Uri("https://modelproductioncase/items"),
        Id = Guid.NewGuid().ToString(),
        Time = DateTimeOffset.UtcNow,
        DataContentType = "application/json",
        Data = JsonSerializer.Serialize(new
        {
          Id = item.Id,
          Name = item.Name,
          Status = item.Status
        })
      };

      await SendCloudEventAsync(cloudEvent);
    }

    public async Task SendItemDeletedEventAsync(int itemId)
    {
      var cloudEvent = new CloudEvent
      {
        Type = "com.modelproductioncase.item.deleted",
        Source = new Uri("https://modelproductioncase/items"),
        Id = Guid.NewGuid().ToString(),
        Time = DateTimeOffset.UtcNow,
        DataContentType = "application/json",
        Data = JsonSerializer.Serialize(new { Id = itemId })
      };

      await SendCloudEventAsync(cloudEvent);
    }

    private async Task SendCloudEventAsync(CloudEvent cloudEvent)
    {
      var bytes = _formatter.EncodeStructuredModeMessage(cloudEvent, out var contentType);
      var readOnlySequence = new ReadOnlySequence<byte>(bytes);

      await _producer.Send(new MessageMetadata(), readOnlySequence);
    }

    public void Dispose()
    {
      _producer?.DisposeAsync().AsTask().Wait();
    }
  }
}
