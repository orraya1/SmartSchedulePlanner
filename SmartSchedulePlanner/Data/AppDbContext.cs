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
        public DbSet<StudyProgress> StudyProgresses { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<StudyActivity>()
                .ToTable("Activities");

            modelBuilder.Entity<ActivitySubject>()
                .HasOne(a => a.StudyActivity)
                .WithMany(a => a.ActivitySubjects)
                .HasForeignKey(a => a.StudyActivityId);

            modelBuilder.Entity<StudyProgress>()
                .HasOne(x => x.Schedule)
                .WithMany()
                .HasForeignKey(x => x.ScheduleId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}