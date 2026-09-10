namespace SmartSchedulePlanner.Models
{
    public class TimeSlot
    {
        public DateTime StudyDate { get; set; }

        public TimeSpan StartTime { get; set; }

        public TimeSpan EndTime { get; set; }
    }
}