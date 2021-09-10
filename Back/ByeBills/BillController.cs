using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Threading.Tasks;
using ByeBoletosRepository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.IdentityModel.JsonWebTokens;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ByeBoletos
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class BillController : ControllerBase
    {
        private BillRepository _repository = new BillRepository();
        // GET: api/<BillController>
        [HttpGet]
        public IActionResult Get()
        {
            string email = GetEmail();
            return Ok(_repository.GetAll(email));
        }

        // GET api/<BillController>/5
        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            try
            {
                Bill bill = _repository.Get(id);
                return Ok(bill);
            }
            catch (Exception e)
            {
               return BadRequest(e.Message);
            }
        }

        // POST api/<BillController>
        [HttpPost]
        public IActionResult Post([FromBody] Bill bill)
        {
            try
            {
                string email = GetEmail();
                bill.Email = email;
                bill.Id = null;
                _repository.Add(bill);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
            
        }

        // PUT api/<BillController>/5
        [HttpPut("{id}")]
        public IActionResult Put(int id, [FromBody] Bill newBill)
        {
            try
            {
                _repository.Update(id, newBill);
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
            
        }

        // DELETE api/<BillController>/5
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            try
            {
                _repository.Remove(id);
                return NoContent();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        private string GetEmail()
        {
            string jwt = Request.Headers["Authorization"].ToString().Replace("Bearer ", string.Empty); ;
            var token = new JwtSecurityToken(jwt);
            string email = token.Claims.First(x => x.Type == "email").Value;
            return email;
        }
    }
}
