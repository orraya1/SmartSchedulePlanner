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
            ViewBag.ActivityId = id;

            var list = _context.ActivitySubjects
                .Where(x => x.StudyActivityId == id)
                .ToList();


            return View(list);
        }

        // หน้าเพิ่มวิชา
        public IActionResult Create(int id)
        {
            var model = new ActivitySubject
            {
                StudyActivityId = id
            };

            return View(model);
        }
        public IActionResult Edit(int id)
        {
            var subject = _context.ActivitySubjects.Find(id);

            if (subject == null)
                return NotFound();

            return View(subject);
        }

        
        [HttpPost]
        public IActionResult Create(ActivitySubject model)
        {
            if (!ModelState.IsValid)
                return View(model);

            // บังคับไม่ให้ส่ง Id ไป SQL
            model.Id = 0;

            _context.ActivitySubjects.Add(model);

            _context.SaveChanges();

            return RedirectToAction(nameof(Index),
                new { id = model.StudyActivityId });
        }
        [HttpPost]
        public IActionResult Edit(ActivitySubject model)
        {
            if (!ModelState.IsValid)
                return View(model);

            _context.ActivitySubjects.Update(model);
            _context.SaveChanges();

            return RedirectToAction(
                "Index",
                new { id = model.StudyActivityId });
        }
        public IActionResult Delete(int id)
        {
            var subject = _context.ActivitySubjects.Find(id);

            if (subject == null)
                return NotFound();

            return View(subject);
        }

        [HttpPost, ActionName("Delete")]
        public IActionResult DeleteConfirmed(int id)
        {
            var subject = _context.ActivitySubjects.Find(id);

            if (subject != null)
            {
                int activityId = subject.StudyActivityId;

                _context.ActivitySubjects.Remove(subject);
                _context.SaveChanges();

                return RedirectToAction(
                    "Index",
                    new { id = activityId });
            }

            return RedirectToAction("Index");
        }
    }
}