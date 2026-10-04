using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SmartSchedulePlanner.Data;
using SmartSchedulePlanner.Models;
using SmartSchedulePlanner.Services;

namespace SmartSchedulePlanner.Controllers
{
    public class ScheduleController : Controller
    {
        private readonly AppDbContext _context;
        private readonly GeneticAlgorithmService _ga;

        public ScheduleController(
            AppDbContext context,
            GeneticAlgorithmService ga)
        {
            _context = context;
            _ga = ga;
        }

        // แสดง Activities ของ User ที่ Login อยู่
        public IActionResult Index()
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var activities = _context.StudyActivities
                .Where(x => x.UserId == userId.Value)
                .OrderByDescending(x => x.Id)
                .ToList();

            return View(activities);
        }

        // สร้าง Schedule ด้วย Genetic Algorithm
        // (เปลี่ยนเป็น POST เพราะมีการลบ/สร้างข้อมูลในฐานข้อมูล)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Generate(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            // ตรวจสอบว่า Activity เป็นของ User ที่ Login อยู่
            var activity = _context.StudyActivities
                .Include(a => a.ActivitySubjects)
                .FirstOrDefault(a =>
                    a.Id == id &&
                    a.UserId == userId.Value);

            if (activity == null)
                return NotFound();

            if (activity.IsScheduleConfirmed)
            {
                TempData["Error"] =
                    "ตารางกิจกรรมนี้ได้รับการยืนยันแล้ว ไม่สามารถสร้างตารางใหม่ได้";

                return RedirectToAction(
                    "ViewSchedule",
                    new { id });
            }

            if (!activity.ActivitySubjects.Any())
            {
                TempData["Error"] = "กรุณาเพิ่มวิชาก่อนสร้างตาราง";

                return RedirectToAction(
                    "Details",
                    "StudyActivity",
                    new { id });
            }

            int totalWeight = activity.ActivitySubjects
                .Sum(x => x.Weight);

            if (totalWeight != 100)
            {
                TempData["Error"] =
                    $"Weight รวมปัจจุบัน = {totalWeight}% ต้องเท่ากับ 100%";

                return RedirectToAction(
                    "Details",
                    "StudyActivity",
                    new { id });
            }

            // ตรวจว่าช่วงวันที่/เวลาอ่านชนกับกิจกรรมอื่นของ User คนนี้หรือไม่
            var otherActivities = _context.StudyActivities
                .AsNoTracking()
                .Where(x =>
                    x.UserId == userId.Value &&
                    x.Id != id)
                .ToList();

            var conflict = ActivityConflictChecker
                .FindConflict(activity, otherActivities);

            if (conflict != null)
            {
                TempData["Error"] =
                    ActivityConflictChecker.Describe(conflict) +
                    " จึงไม่สามารถสร้างตารางได้ " +
                    "กรุณาลบกิจกรรมใดกิจกรรมหนึ่ง " +
                    "หรือสร้างกิจกรรมใหม่ที่ไม่ซ้อนเวลากัน";

                return RedirectToAction(
                    "Details",
                    "StudyActivity",
                    new { id });
            }

            // Generate ตารางด้วย Genetic Algorithm
            var result = _ga.Generate(
                activity,
                activity.ActivitySubjects.ToList());

            // ไม่มีช่วงเวลาอ่านให้สร้างตารางเลย
            // ไม่ลบตารางเดิม เพื่อไม่ให้ข้อมูลหาย
            if (result.Genes.Count == 0)
            {
                TempData["Error"] =
                    "ไม่สามารถสร้างตารางได้ เพราะไม่มีช่วงเวลาอ่านที่ใช้ได้ " +
                    "(ช่วงเวลาอ่านต่อวันสั้นกว่า 1 ชั่วโมง หรืออยู่ในช่วงพักเที่ยง)";

                return RedirectToAction(
                    "Details",
                    "StudyActivity",
                    new { id });
            }

            // ลบตารางเก่าของ Activity นี้ก่อน
            var oldSchedules = _context.Schedules
                .Where(x => x.StudyActivityId == id)
                .ToList();

            _context.Schedules.RemoveRange(oldSchedules);

            // บันทึกตารางใหม่จาก GA
            foreach (var gene in result.Genes)
            {
                _context.Schedules.Add(
                    new Schedule
                    {
                        StudyActivityId = activity.Id,
                        SubjectName = gene.SubjectName,
                        StudyDate = gene.StudyDate,
                        StartTime = gene.StartTime,
                        EndTime = gene.EndTime
                    });
            }

            _context.SaveChanges();

            TempData["Success"] =
                $"สร้างตารางสำเร็จ Fitness = {result.Fitness:0.00}";

            TempData["Fitness"] =
                result.Fitness.ToString("0.00");

            return RedirectToAction(
                "ViewSchedule",
                new { id });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ConfirmSchedule(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            // ตรวจสอบว่า Activity เป็นของ User ที่ Login อยู่
            var activity = _context.StudyActivities
                .FirstOrDefault(x =>
                    x.Id == id &&
                    x.UserId == userId.Value);

            if (activity == null)
                return NotFound();

            var hasSchedule = _context.Schedules
                .Any(x => x.StudyActivityId == id);

            if (!hasSchedule)
            {
                TempData["Error"] =
                    "ยังไม่มีตารางสำหรับยืนยัน";

                return RedirectToAction(
                    "ViewSchedule",
                    new { id });
            }

            activity.IsScheduleConfirmed = true;

            _context.SaveChanges();

            TempData["Success"] =
                "ยืนยันตารางเรียบร้อยแล้ว";

            return RedirectToAction(
                "ViewSchedule",
                new { id });
        }

        // แสดงตารางของ Activity
        public IActionResult ViewSchedule(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            // ตรวจสอบว่า Activity เป็นของ User ที่ Login อยู่
            var activity = _context.StudyActivities
                .FirstOrDefault(a =>
                    a.Id == id &&
                    a.UserId == userId.Value);

            if (activity == null)
                return NotFound();

            var schedules = _context.Schedules
        .Where(x => x.StudyActivityId == id)
        .OrderBy(x => x.StudyDate)
        .ThenBy(x => x.StartTime)
        .ToList();

            var scheduleIds = schedules
                .Select(x => x.Id)
                .ToList();

            var progressList = _context.StudyProgresses
                .Where(x => scheduleIds.Contains(x.ScheduleId))
                .ToList();

            var progressBySchedule = progressList
                .ToDictionary(x => x.ScheduleId);

            ViewBag.ActivityId = id;
            ViewBag.Fitness = TempData["Fitness"];
            ViewBag.ProgressBySchedule = progressBySchedule;
            ViewBag.IsScheduleConfirmed =
    _context.StudyActivities
        .Where(x => x.Id == id)
        .Select(x => x.IsScheduleConfirmed)
        .FirstOrDefault();

            return View(schedules);
        }
    }
}