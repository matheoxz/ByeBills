using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using ByeBoletosRepository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.IdentityModel.Tokens;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ByeBoletos
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {

        private UserRepository _repository = new UserRepository();

        [HttpPost("login")]
        [AllowAnonymous]
        public IActionResult Login([FromBody] User user)
        {
            // Recupera o usuário
            var _user = _repository.Get(user.Email, user.Password);

            // Verifica se o usuário existe
            if (_user == null)
                return NotFound(new { message = "Usuário ou senha inválidos" });

            // Gera o Token
            var token = GenerateToken(_user);

            // Oculta a senha
            _user.Password = "";

            // Retorna os dados
            return Ok(new
            {
                user = _user,
                token = token
            });
        }

        // POST api/<UserController>
        [HttpPost("new")]
        [AllowAnonymous]
        public IActionResult Post([FromBody] User user)
        {
            try
            {
                _repository.Add(user);
                return Ok();
            }
            catch (Exception a)
            {
                return BadRequest(a.Message);
            }
        }

        // DELETE api/<UserController>/5
        [HttpDelete("{email}")]
        [Authorize]
        public IActionResult Delete(string email)
        {
            try
            {
                _repository.Remove(email);
                return NoContent();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        private static string GenerateToken(User user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes("fedaf7d8863b48e197b9287d492b708e");
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Username),
                    new Claim(ClaimTypes.Email, user.Email),
                    new Claim(ClaimTypes.Name, user.Name)
                }),
                Expires = DateTime.UtcNow.AddHours(2),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
