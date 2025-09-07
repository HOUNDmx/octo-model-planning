using Microsoft.EntityFrameworkCore;

namespace ModelProductionCase.Data
{
    public class ModelProductionContext : DbContext
    {
        public ModelProductionContext(DbContextOptions<ModelProductionContext> options)
            : base(options) { }
        public DbSet<ModelProductionCase.Models.Item> Items { get; set; }
    }
}
