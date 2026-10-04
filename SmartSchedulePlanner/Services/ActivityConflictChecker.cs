using SmartSchedulePlanner.Models;

namespace SmartSchedulePlanner.Services
{
    public static class ActivityConflictChecker
    {
        // หากิจกรรมอื่นที่ช่วงวันที่ "และ" เวลาอ่านต่อวันซ้อนกับกิจกรรมนี้
        public static StudyActivity? FindConflict(
            StudyActivity activity,
            IEnumerable<StudyActivity> others)
        {
            return others.FirstOrDefault(o =>
                o.Id != activity.Id
                &&
                activity.StartDate.Date <= o.EndDate.Date
                &&
                activity.EndDate.Date >= o.StartDate.Date
                &&
                activity.DailyStartTime < o.DailyEndTime
                &&
                activity.DailyEndTime > o.DailyStartTime);
        }

        // ข้อความอธิบายว่าชนกับกิจกรรมไหน
        public static string Describe(StudyActivity conflict)
        {
            string dates =
                conflict.StartDate.ToString("dd/MM/yyyy")
                + " - "
                + conflict.EndDate.ToString("dd/MM/yyyy");

            string times =
                conflict.DailyStartTime.ToString(@"hh\:mm")
                + " - "
                + conflict.DailyEndTime.ToString(@"hh\:mm");

            return "ช่วงวันที่และเวลาอ่านชนกับกิจกรรม \""
                + conflict.ActivityName
                + "\" ("
                + dates
                + " เวลา "
                + times
                + ")";
        }
    }
}
