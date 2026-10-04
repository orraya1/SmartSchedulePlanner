using Microsoft.AspNetCore.Mvc;
using SmartSchedulePlanner.Data;
using SmartSchedulePlanner.Models;

namespace SmartSchedulePlanner.Controllers
{
    public class StudyProgressController : Controller
    {
        private readonly AppDbContext _context;

        public StudyProgressController(AppDbContext context)
        {
            _context = context;
        }

        // ดึง Schedule เฉพาะที่เป็นของ User ที่ Login อยู่
        private Schedule? GetOwnedSchedule(int scheduleId, int userId)
        {
            return _context.Schedules
                .FirstOrDefault(x =>
                    x.Id == scheduleId &&
                    x.StudyActivity != null &&
                    x.StudyActivity.UserId == userId);
        }

        // GET: StudyProgress/Create?scheduleId=1
        public IActionResult Create(int scheduleId)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var schedule = GetOwnedSchedule(scheduleId, userId.Value);

            if (schedule == null)
                return NotFound();

            var progress = _context.StudyProgresses
                .FirstOrDefault(x => x.ScheduleId == scheduleId);

            if (progress == null)
            {
                progress = new StudyProgress
                {
                    ScheduleId = scheduleId,
                    ProgressPercent = 0,
                    IsCompleted = false,
                    ActualMinutes = 0,
                    Note = ""
                };
            }

            ViewBag.Schedule = schedule;

            return View(progress);
        }


        // POST: StudyProgress/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(StudyProgress model)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var schedule = GetOwnedSchedule(model.ScheduleId, userId.Value);

            if (schedule == null)
                return NotFound();


            // เวลาที่กำหนดในตาราง
            int scheduledMinutes =
                (int)(schedule.EndTime - schedule.StartTime)
                .TotalMinutes;


            // ตรวจสอบเวลาอ่านจริง
            if (model.ActualMinutes < 0)
            {
                ModelState.AddModelError(
                    "ActualMinutes",
                    "เวลาอ่านจริงต้องไม่ต่ำกว่า 0 นาที");
            }

            if (model.ActualMinutes > scheduledMinutes)
            {
                ModelState.AddModelError(
                    "ActualMinutes",
                    $"เวลาอ่านจริงต้องไม่เกิน {scheduledMinutes} นาที");
            }


            // กำหนดสถานะ
            if (model.ProgressPercent >= 100)
            {
                model.ProgressPercent = 100;
                model.IsCompleted = true;
            }
            else if (model.ProgressPercent <= 0)
            {
                model.ProgressPercent = 0;
                model.IsCompleted = false;
            }
            else
            {
                model.IsCompleted = false;
            }


            // ถ้ามี Error ให้กลับหน้าเดิม
            if (!ModelState.IsValid)
            {
                ViewBag.Schedule = schedule;
                return View(model);
            }


            // ตรวจสอบว่ามีข้อมูลเดิมหรือไม่
            var existing = _context.StudyProgresses
                .FirstOrDefault(x =>
                    x.ScheduleId == model.ScheduleId);


            // =========================
            // เพิ่มข้อมูลใหม่
            // =========================

            if (existing == null)
            {
                // ไม่ใช้ Id ที่ส่งมาจากหน้าเว็บ
                model.Id = 0;

                model.UpdatedAt = DateTime.Now;

                _context.StudyProgresses.Add(model);
            }

            // =========================
            // แก้ไขข้อมูลเดิม
            // =========================

            else
            {
                existing.ProgressPercent =
                    model.ProgressPercent;

                existing.IsCompleted =
                    model.IsCompleted;

                existing.ActualMinutes =
                    model.ActualMinutes;

                existing.Note =
                    model.Note;

                existing.UpdatedAt =
                    DateTime.Now;
            }


            _context.SaveChanges();

            // ตรวจสอบว่ากิจกรรมทำครบทุกตารางแล้วหรือยัง
            var activityId = schedule.StudyActivityId;

            var activitySchedules = _context.Schedules
                .Where(x => x.StudyActivityId == activityId)
                .ToList();

            var activityScheduleIds = activitySchedules
                .Select(x => x.Id)
                .ToList();

            var activityProgress = _context.StudyProgresses
                .Where(x =>
                    activityScheduleIds.Contains(x.ScheduleId))
                .ToList();

            bool isActivityCompleted =
                activitySchedules.Count > 0 &&
                activitySchedules.All(schedule =>
                {
                    var progress = activityProgress
                        .FirstOrDefault(x =>
                            x.ScheduleId == schedule.Id);

                    return progress != null &&
                           progress.IsCompleted &&
                           progress.ProgressPercent == 100;
                });

            var activity = _context.StudyActivities
                .FirstOrDefault(x => x.Id == activityId);

            if (activity != null)
            {
                activity.IsCompleted = isActivityCompleted;
                _context.SaveChanges();
            }

            TempData["Success"] =
                "บันทึกผลการอ่านเรียบร้อยแล้ว";

            return RedirectToAction(
                "ViewSchedule",
                "Schedule",
                new
                {
                    id = schedule.StudyActivityId
                });
        }
    }
}