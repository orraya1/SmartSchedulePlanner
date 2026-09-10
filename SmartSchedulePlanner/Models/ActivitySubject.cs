using System.ComponentModel.DataAnnotations;

namespace SmartSchedulePlanner.Models
{
    public class ActivitySubject
    {
        public int Id { get; set; }
        public int? AllocatedHours { get; set; }

        public int StudyActivityId { get; set; }

        public StudyActivity? StudyActivity { get; set; }

        [Required(ErrorMessage = "กรุณากรอกชื่อวิชา")]
        [Display(Name = "ชื่อวิชา")]
        public string SubjectName { get; set; } = string.Empty;

        [Display(Name = "Weight (%)")]
        [Range(1, 100)]
        public int Weight { get; set; }
    }
}