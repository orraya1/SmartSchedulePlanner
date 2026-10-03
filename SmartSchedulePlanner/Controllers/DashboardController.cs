using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SmartSchedulePlanner.Data;

namespace SmartSchedulePlanner.Controllers
{
    public class DashboardController : Controller
    {
        private readonly AppDbContext _context;

        public DashboardController(AppDbContext context)
        {
            _context = context;
        }

        public IActionResult Index(
            int? month,
            int? year,
            string? weekStartDate,
            string? date)
        {
            // ตรวจสอบ User ที่ Login อยู่
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            DateTime today = DateTime.Today;

            if (!string.IsNullOrEmpty(date) &&
                DateTime.TryParseExact(
                    date,
                    "yyyy-MM-dd",
                    null,
                    System.Globalization.DateTimeStyles.None,
                    out DateTime selectedDate))
            {
                today = selectedDate.Date;
            }

            // =====================================================
            // สัปดาห์
            // =====================================================

            DateTime weekStart;

            if (!string.IsNullOrEmpty(weekStartDate) &&
                DateTime.TryParseExact(
                    weekStartDate,
                    "yyyy-MM-dd",
                    null,
                    System.Globalization.DateTimeStyles.None,
                    out DateTime selectedWeek))
            {
                weekStart = selectedWeek.Date;
            }
            else
            {
                int diff =
                    (7 + (today.DayOfWeek - DayOfWeek.Monday)) % 7;

                weekStart = today.AddDays(-diff).Date;
            }

            DateTime weekEnd = weekStart.AddDays(7);

            // =====================================================
            // เดือนที่ต้องการแสดงในปฏิทิน
            // =====================================================

            DateTime monthStart;

            if (month.HasValue && year.HasValue)
            {
                monthStart = new DateTime(
                    year.Value,
                    month.Value,
                    1);
            }
            else
            {
                monthStart = new DateTime(
                    today.Year,
                    today.Month,
                    1);
            }

            // =====================================================
            // ตารางของ User ที่ Login อยู่เท่านั้น
            // =====================================================

            var schedules = _context.Schedules
    .AsNoTracking()
    .Include(x => x.StudyActivity)
    .Where(s =>
        s.StudyActivity != null &&
        s.StudyActivity.UserId == userId.Value)
    .OrderBy(x => x.StudyDate)
    .ThenBy(x => x.StartTime)
    .ToList();

            // =====================================================
            // กิจกรรมของ User ที่ Login อยู่
            // =====================================================

            int totalActivities =
                _context.StudyActivities
                    .Count(x => x.UserId == userId.Value);

            // =====================================================
            // วิชาของ User ที่ Login อยู่
            // =====================================================

            int totalSubjects =
                _context.ActivitySubjects
                    .Where(x =>
                        x.StudyActivity != null &&
                        x.StudyActivity.UserId == userId.Value)
                    .Select(x => x.SubjectName)
                    .Distinct()
                    .Count();

            // =====================================================
            // ชั่วโมงอ่านทั้งหมด
            // =====================================================

            double totalStudyHours =
                schedules.Sum(x =>
                    (x.EndTime - x.StartTime).TotalHours);

            // =====================================================
            // ตารางวันนี้
            // =====================================================

            var todaySchedules =
                schedules
                    .Where(x =>
                        x.StudyDate.Date == today)
                    .OrderBy(x => x.StartTime)
                    .ToList();

            // =====================================================
            // ตารางสัปดาห์นี้
            // =====================================================

            var weekSchedules =
                schedules
                    .Where(x =>
                        x.StudyDate.Date >= weekStart &&
                        x.StudyDate.Date < weekEnd)
                    .OrderBy(x => x.StudyDate)
                    .ThenBy(x => x.StartTime)
                    .ToList();

            // =====================================================
            // ตารางเดือนที่เลือก
            // =====================================================

            DateTime monthEnd =
                monthStart.AddMonths(1);

            var monthSchedules =
                schedules
                    .Where(x =>
                        x.StudyDate.Date >= monthStart &&
                        x.StudyDate.Date < monthEnd)
                    .OrderBy(x => x.StudyDate)
                    .ThenBy(x => x.StartTime)
                    .ToList();

            // =====================================================
            // Weight ของวิชาเฉพาะ User ที่ Login
            // =====================================================

            var subjectWeights =
                _context.ActivitySubjects
                    .AsNoTracking()
                    .Where(x =>
                        x.StudyActivity != null &&
                        x.StudyActivity.UserId == userId.Value)
                    .GroupBy(x => x.SubjectName)
                    .Select(g => new
                    {
                        SubjectName = g.Key,
                        Weight = g.Select(x => x.Weight)
                                  .FirstOrDefault()
                    })
                    .ToList();

            // =====================================================
            // การกระจายเวลาอ่านตาม Weight
            // =====================================================

            var subjectDistribution =
                subjectWeights
                    .Select(x =>
                    {
                        double hours =
                            schedules
                                .Where(s =>
                                    s.SubjectName ==
                                    x.SubjectName)
                                .Sum(s =>
                                    (s.EndTime -
                                     s.StartTime)
                                    .TotalHours);

                        double percentage =
                            totalStudyHours > 0
                                ? (hours / totalStudyHours) * 100
                                : 0;

                        return new
                        {
                            SubjectName = x.SubjectName,
                            Weight = x.Weight,
                            Hours = hours,
                            Percentage = percentage
                        };
                    })
                    .OrderByDescending(x => x.Weight)
                    .ToList();

            // =====================================================
            // ส่งข้อมูลไป View
            // =====================================================

            ViewBag.SubjectDistribution =
                subjectDistribution;

            ViewBag.TotalActivities =
                totalActivities;

            ViewBag.TotalSubjects =
                totalSubjects;

            ViewBag.TotalStudyHours =
                totalStudyHours;

            ViewBag.TodaySchedules =
                todaySchedules;

            ViewBag.WeekSchedules =
                weekSchedules;

            ViewBag.MonthSchedules =
                monthSchedules;

            ViewBag.Today =
                today;

            ViewBag.WeekStart =
                weekStart;

            ViewBag.MonthStart =
                monthStart;

            return View(schedules);
        }
    }
}