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

        public IActionResult Generate(int id)
        {
            var activity = _context.StudyActivities
                .Include(a => a.ActivitySubjects)
                .FirstOrDefault(a => a.Id == id);

            if (activity == null)
                return NotFound();

            int totalWeight = activity.ActivitySubjects.Sum(x => x.Weight);

            if (totalWeight != 100)
            {
                TempData["Error"] =
                    $"Weight รวมปัจจุบัน = {totalWeight}% ต้องเท่ากับ 100%";

                return RedirectToAction(
                    "Details",
                    "StudyActivity",
                    new { id });
            }

            var result = _ga.Generate(
     activity,
     activity.ActivitySubjects.ToList());
            // ลบตารางเก่าก่อน
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
     $"สร้างตารางสำเร็จ Fitness = {result.Fitness}";

            return RedirectToAction(
                "ViewSchedule",
                new { id });
        }
        public IActionResult ViewSchedule(int id)
        {
            var schedules = _context.Schedules
                .Where(x => x.StudyActivityId == id)
                .OrderBy(x => x.StudyDate)
                .ThenBy(x => x.StartTime)
                .ToList();

            var activity = _context.StudyActivities
                .FirstOrDefault(x => x.Id == id);

            if (activity == null)
                return NotFound();

            ViewBag.Activity = activity;

            return View(schedules);
        }
    }
}