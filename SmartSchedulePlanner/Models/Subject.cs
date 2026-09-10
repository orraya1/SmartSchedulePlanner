using System.ComponentModel.DataAnnotations;

namespace SmartSchedulePlanner.Models
{
    public class Subject
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; } = "";

        public ICollection<ActivitySubject> ActivitySubjects { get; set; }
            = new List<ActivitySubject>();
    }
}