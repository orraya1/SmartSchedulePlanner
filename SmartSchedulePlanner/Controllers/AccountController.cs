using Microsoft.AspNetCore.Mvc;
using SmartSchedulePlanner.Data;
using SmartSchedulePlanner.Models;
using SmartSchedulePlanner.ViewModels;

namespace SmartSchedulePlanner.Controllers
{
    public class AccountController : Controller
    {
        private readonly AppDbContext _context;

        public AccountController(AppDbContext context)
        {
            _context = context;
        }

        // Login
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(LoginViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            var user = _context.Users.FirstOrDefault(x =>
                x.Email == model.Email &&
                x.Password == model.Password);

            if (user == null)
            {
                ViewBag.Error = "อีเมลหรือรหัสผ่านไม่ถูกต้อง";
                return View(model);
            }

            HttpContext.Session.SetInt32("UserId", user.Id);
            HttpContext.Session.SetString("UserName", user.FullName);

            return RedirectToAction("Index", "Dashboard");
        }

        // Register
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Register(RegisterViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            if (_context.Users.Any(x => x.Email == model.Email))
            {
                ViewBag.Error = "อีเมลนี้ถูกใช้งานแล้ว";
                return View(model);
            }

            User user = new User()
            {
                FullName = model.FullName,
                Email = model.Email,
                Password = model.Password
            };

            _context.Users.Add(user);
            _context.SaveChanges();

            return RedirectToAction("Login");
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Login");
        }
    }
}