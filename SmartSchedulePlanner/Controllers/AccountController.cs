using System.Security.Cryptography;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SmartSchedulePlanner.Data;
using SmartSchedulePlanner.Models;
using SmartSchedulePlanner.ViewModels;

namespace SmartSchedulePlanner.Controllers
{
    public class AccountController : Controller
    {
        private readonly AppDbContext _context;

        private readonly PasswordHasher<User> _hasher = new();

        // รหัสผ่านที่เข้ารหัสด้วย PasswordHasher (v3) จะขึ้นต้นด้วยข้อความนี้เสมอ
        private const string HashPrefix = "AQAAAA";

        public AccountController(AppDbContext context)
        {
            _context = context;
        }

        // ตรวจรหัสผ่าน และอัปเกรดรหัสผ่านเก่า (plain text) เป็นแบบเข้ารหัสให้อัตโนมัติ
        private bool VerifyPassword(User user, string password)
        {
            // บัญชีเก่าที่ยังเก็บรหัสผ่านเป็นข้อความธรรมดา
            if (!user.Password.StartsWith(HashPrefix, StringComparison.Ordinal))
            {
                var stored = Encoding.UTF8.GetBytes(user.Password);
                var provided = Encoding.UTF8.GetBytes(password);

                if (!CryptographicOperations.FixedTimeEquals(stored, provided))
                    return false;

                user.Password = _hasher.HashPassword(user, password);
                _context.SaveChanges();

                return true;
            }

            var result = _hasher.VerifyHashedPassword(
                user,
                user.Password,
                password);

            if (result == PasswordVerificationResult.Failed)
                return false;

            if (result == PasswordVerificationResult.SuccessRehashNeeded)
            {
                user.Password = _hasher.HashPassword(user, password);
                _context.SaveChanges();
            }

            return true;
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
                x.Email == model.Email);

            if (user == null || !VerifyPassword(user, model.Password))
            {
                ViewBag.Error = "อีเมลหรือรหัสผ่านไม่ถูกต้อง";
                return View(model);
            }

            // ล้าง Session เดิมก่อน (ป้องกัน session fixation)
            HttpContext.Session.Clear();

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
                Email = model.Email
            };

            // เก็บรหัสผ่านแบบเข้ารหัส (hash) ไม่เก็บเป็นข้อความธรรมดา
            user.Password = _hasher.HashPassword(user, model.Password);

            _context.Users.Add(user);
            _context.SaveChanges();

            return RedirectToAction("Login");
        }

        public IActionResult Logout()
        {
            return View();
        }

        [HttpPost]
        public IActionResult ConfirmLogout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Login");
        }
    }
}