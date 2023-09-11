
using System.Security.Cryptography;
using System.Text;
using API.Data;
using API.Entities;
using API.DTO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API.Controllers
{
    public class AccountController:BaseApiController
    {
        private readonly DataContext _context;

        public AccountController(DataContext context)
        {
            _context = context;
        }

        [HttpPost("register")]
        public async Task<ActionResult<AppUser>>  Register(RegisterDTO registerDTO)
        {
            if (await CheckUserExist(registerDTO.UserName)) return BadRequest("Username Already Taken");

            using var hmac= new HMACSHA512();
            var user= new AppUser();
            user.UserName=registerDTO.UserName.ToLower();
            user.PasswordHash=hmac.ComputeHash(Encoding.UTF8.GetBytes(registerDTO.Password));
            user.PasswordSalt=hmac.Key;

            _context.Users.Add(user);

            await _context.SaveChangesAsync();

            return user;
        }
        
        [HttpPost("login")]
        public async Task<ActionResult<AppUser>> Login(LoginDto loginDTO)
        {
            var Login_user= await _context.Users.SingleOrDefaultAsync(x=>x.UserName==loginDTO.UserName);
            if (Login_user==null) return Unauthorized("invalid username");

            using var hmac=new HMACSHA512(Login_user.PasswordSalt);
            var ComputedHash=hmac.ComputeHash(Encoding.UTF8.GetBytes(loginDTO.Password));
            for (int i=0;i<ComputedHash.Length;i++)
            {
                if (ComputedHash[i] != Login_user.PasswordHash[i]) return Unauthorized("Invalid Password");
            }
            return Login_user;
 
        }

        private async Task<bool> CheckUserExist(string username)
        {
            return await _context.Users.AnyAsync(x=>x.UserName.ToLower()==username.ToLower());
        }
    }
}