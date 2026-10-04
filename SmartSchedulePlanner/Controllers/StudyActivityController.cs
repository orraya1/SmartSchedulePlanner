using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SmartSchedulePlanner.Data;
using SmartSchedulePlanner.Models;
using SmartSchedulePlanner.Services;

namespace SmartSchedulePlanner.Controllers
{
    public class StudyActivityController : Controller
    {
        private readonly AppDbContext _context;

        public StudyActivityController(AppDbContext context)
        {
            _context = context;
        }

        // =========================
        // Activity List
        // =========================
        public IActionResult Index()
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var activities = _context.StudyActivities
                .Include(a => a.User)
                .Where(a => a.UserId == userId.Value)
                .ToList();

            return View(activities);
        }

        // =========================
        // Create
        // =========================
        public IActionResult Create()
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(StudyActivity activity)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            // ตรวจสอบเวลา
            if (activity.DailyStartTime >= activity.DailyEndTime)
            {
                ModelState.AddModelError(
                    nameof(activity.DailyEndTime),
                    "เวลาเริ่มอ่านต้องน้อยกว่าเวลาสิ้นสุด");
            }

            // ตรวจสอบวันที่
            if (activity.StartDate.Date > activity.EndDate.Date)
            {
                ModelState.AddModelError(
                    nameof(activity.EndDate),
                    "วันที่เริ่มต้องไม่หลังวันที่สิ้นสุด");
            }

            // ตรวจว่าชนกับกิจกรรมอื่นของ User คนนี้หรือไม่
            if (ModelState.IsValid)
            {
                var otherActivities = _context.StudyActivities
                    .AsNoTracking()
                    .Where(x => x.UserId == userId.Value)
                    .ToList();

                var conflict = ActivityConflictChecker
                    .FindConflict(activity, otherActivities);

                if (conflict != null)
                {
                    ModelState.AddModelError(
                        string.Empty,
                        ActivityConflictChecker.Describe(conflict) +
                        " กรุณาเปลี่ยนช่วงวันที่หรือเวลาอ่าน");
                }
            }

            if (!ModelState.IsValid)
                return View(activity);

            // ผูกกิจกรรมกับ User ที่ Login อยู่
            activity.UserId = userId.Value;

            // สีประจำ Activity
            var activityColors = new[]
            {
        "#DDE9D5", // เขียวอ่อน
        "#DDECF5", // ฟ้าอ่อน
        "#F5E8D5", // ส้มอ่อน
        "#F5DCDC", // ชมพูอ่อน
        "#EADFF2", // ม่วงอ่อน
        "#DDE8E8", // เขียวอมฟ้า
        "#F1E4D2"  // ครีม
    };

            // นับจำนวน Activity เดิมของ User
            var activityCount = _context.StudyActivities
                .Count(x => x.UserId == userId.Value);

            // กำหนดสีให้ Activity
            activity.Color =
                activityColors[activityCount % activityColors.Length];

            // บันทึก Activity
            _context.StudyActivities.Add(activity);
            _context.SaveChanges();

            return RedirectToAction(nameof(Index));
        }

        // =========================
        // Details
        // =========================
        public IActionResult Details(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var activity = _context.StudyActivities
                .Include(a => a.ActivitySubjects)
                .FirstOrDefault(a =>
                    a.Id == id &&
                    a.UserId == userId.Value);

            if (activity == null)
                return NotFound();

            return View(activity);
        }

        // =========================
        // ดูตารางของกิจกรรม
        // =========================
        public IActionResult Schedule(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            // ตรวจสอบว่ากิจกรรมนี้เป็นของ User ที่ Login อยู่
            var activity = _context.StudyActivities
                .FirstOrDefault(a =>
                    a.Id == id &&
                    a.UserId == userId.Value);

            if (activity == null)
                return NotFound();

            // ดึงตารางของกิจกรรมนี้
            var schedules = _context.Schedules
                .Where(x => x.StudyActivityId == id)
                .OrderBy(x => x.StudyDate)
                .ThenBy(x => x.StartTime)
                .ToList();

            // ถ้ายังไม่มีตาราง
            if (!schedules.Any())
            {
                TempData["Error"] =
                    "กิจกรรมนี้ยังไม่มีตาราง กรุณาสร้างตารางด้วย Genetic Algorithm ก่อน";

                return RedirectToAction(
                    nameof(Details),
                    new { id });
            }

            // เปิดตารางเดิม
            return RedirectToAction(
                "ViewSchedule",
                "Schedule",
                new { id });
        }

        // =========================
        // Delete
        // =========================
        public IActionResult Delete(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var activity = _context.StudyActivities
                .FirstOrDefault(x =>
                    x.Id == id &&
                    x.UserId == userId.Value);

            if (activity == null)
                return NotFound();

            return View(activity);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var activity = _context.StudyActivities
                .FirstOrDefault(x =>
                    x.Id == id &&
                    x.UserId == userId.Value);

            if (activity == null)
                return NotFound();

            // ลบวิชาของกิจกรรม
            var subjects = _context.ActivitySubjects
                .Where(x => x.StudyActivityId == id)
                .ToList();

            _context.ActivitySubjects.RemoveRange(subjects);

            // ลบตารางของกิจกรรม
            var schedules = _context.Schedules
                .Where(x => x.StudyActivityId == id)
                .ToList();

            _context.Schedules.RemoveRange(schedules);

            // ลบกิจกรรม
            _context.StudyActivities.Remove(activity);

            _context.SaveChanges();

            return RedirectToAction(nameof(Index));
        }
    }
}