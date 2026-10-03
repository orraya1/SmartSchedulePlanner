using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SmartSchedulePlanner.Data;
using SmartSchedulePlanner.Models;

namespace SmartSchedulePlanner.Controllers
{
    public class StudySubjectController : Controller
    {
        private readonly AppDbContext _context;

        public StudySubjectController(AppDbContext context)
        {
            _context = context;
        }

        // แสดงวิชาทั้งหมดของกิจกรรม
        public IActionResult Index(int id)
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

            ViewBag.ActivityId = id;

            var list = _context.ActivitySubjects
                .Where(x => x.StudyActivityId == id)
                .ToList();

            return View(list);
        }

        // หน้าเพิ่มวิชา
        public IActionResult Create(int id)
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

            var model = new ActivitySubject
            {
                StudyActivityId = id
            };

            return View(model);
        }

        // หน้าแก้ไขวิชา
        public IActionResult Edit(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var subject = _context.ActivitySubjects
                .Include(x => x.StudyActivity)
                .FirstOrDefault(x =>
                    x.Id == id &&
                    x.StudyActivity != null &&
                    x.StudyActivity.UserId == userId.Value);

            if (subject == null)
                return NotFound();

            return View(subject);
        }

        // บันทึกวิชาใหม่
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(ActivitySubject model)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            // ตรวจสอบว่า Activity เป็นของ User ที่ Login อยู่
            var activity = _context.StudyActivities
                .FirstOrDefault(x =>
                    x.Id == model.StudyActivityId &&
                    x.UserId == userId.Value);

            if (activity == null)
                return NotFound();

            if (!ModelState.IsValid)
                return View(model);

            // ไม่ให้ใช้ Id ที่ส่งมาจากหน้าเว็บ
            model.Id = 0;

            _context.ActivitySubjects.Add(model);
            _context.SaveChanges();

            return RedirectToAction(
                nameof(Index),
                new { id = model.StudyActivityId });
        }

        // บันทึกการแก้ไขวิชา
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(ActivitySubject model)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var subject = _context.ActivitySubjects
                .Include(x => x.StudyActivity)
                .FirstOrDefault(x =>
                    x.Id == model.Id &&
                    x.StudyActivity != null &&
                    x.StudyActivity.UserId == userId.Value);

            if (subject == null)
                return NotFound();

            if (!ModelState.IsValid)
                return View(model);

            // อัปเดตเฉพาะข้อมูลที่ผู้ใช้สามารถแก้ไขได้
            subject.SubjectName = model.SubjectName;
            subject.Weight = model.Weight;

            _context.SaveChanges();

            return RedirectToAction(
                nameof(Index),
                new { id = subject.StudyActivityId });
        }

        // หน้า Confirm ลบวิชา
        public IActionResult Delete(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var subject = _context.ActivitySubjects
                .Include(x => x.StudyActivity)
                .FirstOrDefault(x =>
                    x.Id == id &&
                    x.StudyActivity != null &&
                    x.StudyActivity.UserId == userId.Value);

            if (subject == null)
                return NotFound();

            return View(subject);
        }

        // ยืนยันการลบวิชา
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            var subject = _context.ActivitySubjects
                .Include(x => x.StudyActivity)
                .FirstOrDefault(x =>
                    x.Id == id &&
                    x.StudyActivity != null &&
                    x.StudyActivity.UserId == userId.Value);

            if (subject == null)
                return NotFound();

            int activityId = subject.StudyActivityId;

            _context.ActivitySubjects.Remove(subject);
            _context.SaveChanges();

            return RedirectToAction(
                nameof(Index),
                new { id = activityId });
        }
    }
}