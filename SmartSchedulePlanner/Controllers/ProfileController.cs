using Microsoft.AspNetCore.Mvc;
using SmartSchedulePlanner.Data;

namespace SmartSchedulePlanner.Controllers
{
    public class ProfileController : Controller
    {
        private readonly AppDbContext _context;

        public ProfileController(AppDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            // ตรวจสอบว่ามีผู้ใช้ Login อยู่หรือไม่
            var userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "Account");

            // ดึงข้อมูลเฉพาะ User ที่กำลัง Login
            var user = _context.Users
                .FirstOrDefault(x => x.Id == userId.Value);

            if (user == null)
                return NotFound();

            return View(user);
        }
    }
}