using Microsoft.EntityFrameworkCore;
using SmartSchedulePlanner.Models;

namespace SmartSchedulePlanner.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Schedule> Schedules { get; set; }
        public DbSet<StudyActivity> StudyActivities { get; set; }
        public DbSet<ActivitySubject> ActivitySubjects { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // ใช้ตาราง Activities ในฐานข้อมูล
            modelBuilder.Entity<StudyActivity>().ToTable("Activities");

            modelBuilder.Entity<ActivitySubject>()
                .HasOne(a => a.StudyActivity)
                .WithMany(a => a.ActivitySubjects)
                .HasForeignKey(a => a.StudyActivityId);
        }
    }
}