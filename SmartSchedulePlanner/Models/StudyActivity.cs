using System.ComponentModel.DataAnnotations;

namespace SmartSchedulePlanner.Models
{
    public class StudyActivity
    {
        public int Id { get; set; }

        [Required]
        public string ActivityName { get; set; } = "";

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public TimeSpan DailyStartTime { get; set; }

        public TimeSpan DailyEndTime { get; set; }

        public int UserId { get; set; }

        public User? User { get; set; }

        // สีประจำ Activity สำหรับแสดงบน Dashboard
        public string Color { get; set; } = "#DDE9D5";

        public ICollection<ActivitySubject> ActivitySubjects { get; set; }
            = new List<ActivitySubject>();

        public bool IsScheduleConfirmed { get; set; } = false;
        public bool IsCompleted { get; set; } = false;
    }
}