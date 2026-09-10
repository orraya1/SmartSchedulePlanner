namespace SmartSchedulePlanner.Models
{
    public class Gene
    {
        public string SubjectName { get; set; } = "";

        public DateTime StudyDate { get; set; }

        public TimeSpan StartTime { get; set; }

        public TimeSpan EndTime { get; set; }
    }
}