using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SmartSchedulePlanner.Data;

namespace SmartSchedulePlanner.Controllers
{
    public class AnalyticsController : Controller
    {
        private readonly AppDbContext _context;

        public AnalyticsController(AppDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            // ตรวจสอบว่ามีผู้ใช้ Login อยู่หรือไม่
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");


            // ==========================================
            // ดึง Activity เฉพาะของ User ที่ Login
            // ==========================================

            var activities = _context.StudyActivities
                .AsNoTracking()
                .Where(x => x.UserId == userId.Value)
                .ToList();


            // ==========================================
            // ดึง Schedule เฉพาะของ User ที่ Login
            // ==========================================

            var schedules = _context.Schedules
                .AsNoTracking()
                .Where(s =>
                    _context.StudyActivities.Any(a =>
                        a.Id == s.StudyActivityId &&
                        a.UserId == userId.Value))
                .ToList();


            // ==========================================
            // ดึงวิชาเฉพาะของ User ที่ Login
            // ==========================================

            var subjects = _context.ActivitySubjects
                .AsNoTracking()
                .Where(x =>
                    x.StudyActivity != null &&
                    x.StudyActivity.UserId == userId.Value)
                .ToList();

            // ==========================================
            // ดึงผลการปฏิบัติตามตาราง
            // ==========================================

            var scheduleIds = schedules
                .Select(x => x.Id)
                .ToList();

            var progressList = _context.StudyProgresses
                .AsNoTracking()
                .Where(x => scheduleIds.Contains(x.ScheduleId))
                .ToList();


            // ==========================================
            // ชั่วโมงอ่านทั้งหมด
            // ==========================================

            double totalStudyHours = schedules.Sum(x =>
                (x.EndTime - x.StartTime).TotalHours);


            // ==========================================
            // จำนวนวิชา
            // ==========================================

            int totalSubjects = subjects
                .Select(x => x.SubjectName)
                .Distinct()
                .Count();


            // ==========================================
            // จำนวนกิจกรรม
            // ==========================================

            int totalActivities = activities.Count;


            // ==========================================
            // การกระจายเวลาอ่านตาม Weight
            // ==========================================

            var activityAnalytics = activities
    .Select(activity =>
    {
        var activitySubjects = subjects
            .Where(x => x.StudyActivityId == activity.Id)
            .ToList();

        var activitySchedules = schedules
            .Where(x => x.StudyActivityId == activity.Id)
            .ToList();

        double activityStudyHours = activitySchedules
            .Sum(x =>
                (x.EndTime - x.StartTime).TotalHours);

        var activityScheduleIds = activitySchedules
    .Select(x => x.Id)
    .ToList();

        var activityProgress = progressList
            .Where(x =>
                activityScheduleIds.Contains(x.ScheduleId))
            .ToList();

        int completedCount = activityProgress
            .Count(x => x.IsCompleted);

        int partialCount = activityProgress
            .Count(x =>
                !x.IsCompleted &&
                x.ProgressPercent > 0);

        int notDoneCount = activityProgress
            .Count(x =>
                !x.IsCompleted &&
                x.ProgressPercent == 0);

        int notRecordedCount =
            activitySchedules.Count -
            activityProgress.Count;

        // ==========================================
        // รายละเอียดรายการที่ทำครบ
        // ==========================================

        var completedDetails = activitySchedules
            .Where(schedule =>
            {
                var progress = activityProgress
                    .FirstOrDefault(x =>
                        x.ScheduleId == schedule.Id);

                return progress != null &&
                       progress.IsCompleted;
            })
            .Select(schedule =>
            {
                var progress = activityProgress
                    .First(x =>
                        x.ScheduleId == schedule.Id);

                return new
                {
                    SubjectName = schedule.SubjectName,
                    StudyDate = schedule.StudyDate,
                    StartTime = schedule.StartTime,
                    EndTime = schedule.EndTime,
                    ProgressPercent = progress.ProgressPercent,
                    ActualMinutes = progress.ActualMinutes,
                    Note = progress.Note
                };
            })
            .ToList();


        // ==========================================
        // รายละเอียดรายการที่ทำบางส่วน
        // ==========================================

        var partialDetails = activitySchedules
            .Where(schedule =>
            {
                var progress = activityProgress
                    .FirstOrDefault(x =>
                        x.ScheduleId == schedule.Id);

                return progress != null &&
                       !progress.IsCompleted &&
                       progress.ProgressPercent > 0;
            })
            .Select(schedule =>
            {
                var progress = activityProgress
                    .First(x =>
                        x.ScheduleId == schedule.Id);

                return new
                {
                    SubjectName = schedule.SubjectName,
                    StudyDate = schedule.StudyDate,
                    StartTime = schedule.StartTime,
                    EndTime = schedule.EndTime,
                    ProgressPercent = progress.ProgressPercent,
                    ActualMinutes = progress.ActualMinutes,
                    Note = progress.Note
                };
            })
            .ToList();


        // ==========================================
        // รายละเอียดรายการที่ไม่ได้อ่าน
        // ==========================================

        var notDoneDetails = activitySchedules
            .Where(schedule =>
            {
                var progress = activityProgress
                    .FirstOrDefault(x =>
                        x.ScheduleId == schedule.Id);

                return progress != null &&
                       !progress.IsCompleted &&
                       progress.ProgressPercent == 0;
            })
            .Select(schedule =>
            {
                var progress = activityProgress
                    .First(x =>
                        x.ScheduleId == schedule.Id);

                return new
                {
                    SubjectName = schedule.SubjectName,
                    StudyDate = schedule.StudyDate,
                    StartTime = schedule.StartTime,
                    EndTime = schedule.EndTime,
                    ProgressPercent = progress.ProgressPercent,
                    ActualMinutes = progress.ActualMinutes,
                    Note = progress.Note
                };
            })
            .ToList();


        // ==========================================
        // รายละเอียดรายการที่ยังไม่บันทึก
        // ==========================================

        var notRecordedDetails = activitySchedules
            .Where(schedule =>
                !activityProgress.Any(x =>
                    x.ScheduleId == schedule.Id))
            .Select(schedule =>
            {
                return new
                {
                    SubjectName = schedule.SubjectName,
                    StudyDate = schedule.StudyDate,
                    StartTime = schedule.StartTime,
                    EndTime = schedule.EndTime,
                    ProgressPercent = 0,
                    ActualMinutes = 0,
                    Note = (string?)null
                };
            })
            .ToList();

        var subjectDistribution = activitySubjects
            .GroupBy(x => x.SubjectName)
            .Select(g =>
            {
                var subjectName = g.Key;

                var weight = g
                    .Select(x => x.Weight)
                    .FirstOrDefault();

                double hours = activitySchedules
                    .Where(x =>
                        x.SubjectName == subjectName)
                    .Sum(x =>
                        (x.EndTime - x.StartTime)
                        .TotalHours);

                double percentage =
                    activityStudyHours > 0
                        ? (hours / activityStudyHours) * 100
                        : 0;

                return new
                {
                    SubjectName = subjectName,
                    Weight = weight,
                    Hours = hours,
                    Percentage = percentage
                };
            })
            .OrderByDescending(x => x.Weight)
            .ToList();

        return new
        {
            ActivityId = activity.Id,
            ActivityName = activity.ActivityName,
            StartDate = activity.StartDate,
            EndDate = activity.EndDate,
            TotalStudyHours = activityStudyHours,
            SubjectDistribution = subjectDistribution,

            CompletedCount = completedCount,
            PartialCount = partialCount,
            NotDoneCount = notDoneCount,
            NotRecordedCount = notRecordedCount,

            TotalSchedules = activitySchedules.Count,

            CompletedDetails = completedDetails,
            PartialDetails = partialDetails,
            NotDoneDetails = notDoneDetails,
            NotRecordedDetails = notRecordedDetails
        };
    })
    .ToList();


            // ==========================================
            // ส่งข้อมูลไป View
            // ==========================================

            ViewBag.TotalActivities = totalActivities;

            ViewBag.TotalSubjects = totalSubjects;

            ViewBag.TotalStudyHours = totalStudyHours;

            ViewBag.ActivityAnalytics = activityAnalytics;


            return View();
        }
    }
}