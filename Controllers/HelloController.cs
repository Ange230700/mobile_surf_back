using System.Linq.Expressions;
using Microsoft.AspNetCore.Mvc;

namespace mobile_surf_back.Controllers
 {
    [ApiController]
    [Route("api/[controller]")]
    public class HelloController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(new { message = "Bonjour depuis l'API web"});
        }
    }
 }