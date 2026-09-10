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

        public IActionResult Index()
        {
            DateTime today = DateTime.Today;

            // ตารางทั้งหมด
            var schedules = _context.Schedules
                .AsNoTracking()
                .OrderBy(x => x.StudyDate)
                .ThenBy(x => x.StartTime)
                .ToList();

            // กิจกรรมทั้งหมด
            int totalActivities =
                _context.StudyActivities.Count();

            // วิชาทั้งหมด
            int totalSubjects =
                _context.ActivitySubjects
                    .Select(x => x.SubjectName)
                    .Distinct()
                    .Count();

            // ชั่วโมงอ่านทั้งหมด
            double totalStudyHours =
                schedules.Sum(x =>
                    (x.EndTime - x.StartTime).TotalHours);

            // ตารางวันนี้
            var todaySchedules =
                schedules
                    .Where(x =>
                        x.StudyDate.Date == today)
                    .OrderBy(x => x.StartTime)
                    .ToList();

            // หาวันจันทร์ของสัปดาห์นี้
            int diff =
                (7 + (today.DayOfWeek - DayOfWeek.Monday)) % 7;

            DateTime weekStart =
                today.AddDays(-diff);

            DateTime weekEnd =
                weekStart.AddDays(7);

            // ตารางสัปดาห์นี้
            var weekSchedules =
                schedules
                    .Where(x =>
                        x.StudyDate.Date >= weekStart &&
                        x.StudyDate.Date < weekEnd)
                    .OrderBy(x => x.StudyDate)
                    .ThenBy(x => x.StartTime)
                    .ToList();

            // ตารางเดือนนี้
            DateTime monthStart =
                new DateTime(
                    today.Year,
                    today.Month,
                    1);

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