using Microsoft.AspNetCore.Mvc;
using ModelProductionCase.Data;
using ModelProductionCase.Models;
using ModelProductionCase.Services;
using Microsoft.EntityFrameworkCore;

namespace ModelProductionCase.Controllers
{
    public class ItemsController : Controller
    {
        private readonly ModelProductionContext _context;
        private readonly IEventProducerService _eventProducer;

        public ItemsController(ModelProductionContext context, IEventProducerService eventProducer)
        {
            _context = context;
            _eventProducer = eventProducer;
        }
        public async Task<IActionResult> Index()
        {
            var items = await _context.Items.ToListAsync();
            return View(items);
        }
        public IActionResult Create()
        {
            return View();
        }
        [HttpPost, ActionName("Create")]
        public async Task<IActionResult> Create([Bind("Id, Name, Status")] Item item)
        {
            if (ModelState.IsValid)
            {
                _context.Items.Add(item);
                await _context.SaveChangesAsync();

                // Send event after successful creation
                await _eventProducer.SendItemCreatedEventAsync(item);

                return RedirectToAction("Index");
            }
            return View(item);
        }
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            var item = await _context.Items.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return View(item);
        }
        [HttpPost, ActionName("Edit")]
        public async Task<IActionResult> Edit(int id, [Bind("Id, Name, Status")] Item item)
        {
            if (ModelState.IsValid)
            {
                _context.Update(item);
                await _context.SaveChangesAsync();

                // Send event after successful update
                await _eventProducer.SendItemUpdatedEventAsync(item);

                return RedirectToAction("Index");
            }
            return View(item);
        }
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            var item = await _context.Items.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return View(item);
        }
        [HttpPost, ActionName("Delete")]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var item = await _context.Items.FindAsync(id);
            if (item != null)
            {
                _context.Items.Remove(item);
                await _context.SaveChangesAsync();

                // Send event after successful deletion
                await _eventProducer.SendItemDeletedEventAsync(id);
            }
            return RedirectToAction("Index");
        }
    }
}
