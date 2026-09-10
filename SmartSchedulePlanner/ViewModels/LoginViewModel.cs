using System.ComponentModel.DataAnnotations;

namespace SmartSchedulePlanner.ViewModels
{
    public class LoginViewModel
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; } = "";

        [Required]
        public string Password { get; set; } = "";
    }
}