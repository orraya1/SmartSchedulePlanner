using System.ComponentModel.DataAnnotations;

namespace SmartSchedulePlanner.Models
{
    public class StudyProgress
    {
        public int Id { get; set; }

        public int ScheduleId { get; set; }

        public Schedule? Schedule { get; set; }

        [Required]
        [Range(0, 100)]
        public int ProgressPercent { get; set; }

        public bool IsCompleted { get; set; }

        [Range(0, 1440)]
        public int ActualMinutes { get; set; }

        [StringLength(500)]
        public string? Note { get; set; }

        public DateTime UpdatedAt { get; set; } = DateTime.Now;
    }
}