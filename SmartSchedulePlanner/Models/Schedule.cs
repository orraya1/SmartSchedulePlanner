namespace SmartSchedulePlanner.Models
{
    public class Schedule
    {
        public int Id { get; set; }

        public int StudyActivityId { get; set; }

        public string SubjectName { get; set; } = string.Empty;

        public DateTime StudyDate { get; set; }

        public TimeSpan StartTime { get; set; }

        public TimeSpan EndTime { get; set; }
    }
}