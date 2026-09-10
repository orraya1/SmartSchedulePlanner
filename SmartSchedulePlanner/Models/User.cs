using System.ComponentModel.DataAnnotations;

namespace SmartSchedulePlanner.Models
{
    public class User
    {
        public int Id { get; set; }

        [Required]
        [StringLength(100)]
        public string FullName { get; set; } = "";

        [Required]
        [EmailAddress]
        public string Email { get; set; } = "";

        [Required]
        public string Password { get; set; } = "";

        public string Role { get; set; } = "Student";

        public DateTime CreatedAt { get; set; } = DateTime.Now;

        public ICollection<Subject> Subjects { get; set; } = new List<Subject>();

        public ICollection<StudyActivity> StudyActivities { get; set; }
            = new List<StudyActivity>();
    }
}