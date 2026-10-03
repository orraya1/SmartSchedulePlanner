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

            var subjectDistribution = subjects
                .GroupBy(x => x.SubjectName)
                .Select(g =>
                {
                    var subjectName = g.Key;

                    var weight = g
                        .Select(x => x.Weight)
                        .FirstOrDefault();

                    double hours = schedules
                        .Where(x =>
                            x.SubjectName == subjectName)
                        .Sum(x =>
                            (x.EndTime - x.StartTime)
                            .TotalHours);

                    double percentage =
                        totalStudyHours > 0
                            ? (hours / totalStudyHours) * 100
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


            // ==========================================
            // ส่งข้อมูลไป View
            // ==========================================

            ViewBag.TotalActivities = totalActivities;

            ViewBag.TotalSubjects = totalSubjects;

            ViewBag.TotalStudyHours = totalStudyHours;

            ViewBag.SubjectDistribution =
                subjectDistribution;


            return View();
        }
    }
}