using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SmartSchedulePlanner.Data;
using SmartSchedulePlanner.Models;

namespace SmartSchedulePlanner.Controllers
{
    public class StudyActivityController : Controller
    {
        private readonly AppDbContext _context;

        public StudyActivityController(AppDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            var activities = _context.StudyActivities
                .Include(a => a.User)
                .ToList();

            return View(activities);
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Create(StudyActivity activity)
        {
            if (!ModelState.IsValid)
                return View(activity);

            // ชั่วคราว ใช้ UserId = 1
            activity.UserId = 1;

            _context.StudyActivities.Add(activity);
            _context.SaveChanges();

            return RedirectToAction(nameof(Index));
        }
        public IActionResult Details(int id)
        {
            var activity = _context.StudyActivities
                .Include(a => a.ActivitySubjects)
                .FirstOrDefault(a => a.Id == id);

            if (activity == null)
                return NotFound();

            return View(activity);
        }
        // หน้า Confirm ลบกิจกรรม
        public IActionResult Delete(int id)
        {
            var activity = _context.StudyActivities
                .FirstOrDefault(x => x.Id == id);

            if (activity == null)
                return NotFound();

            return View(activity);
        }

        // ยืนยันการลบกิจกรรม
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            var activity = _context.StudyActivities
                .FirstOrDefault(x => x.Id == id);

            if (activity == null)
                return NotFound();

            // ลบวิชาที่อยู่ในกิจกรรมก่อน
            var subjects = _context.ActivitySubjects
                .Where(x => x.StudyActivityId == id)
                .ToList();

            _context.ActivitySubjects.RemoveRange(subjects);

            // ลบตารางอ่านหนังสือของกิจกรรม
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