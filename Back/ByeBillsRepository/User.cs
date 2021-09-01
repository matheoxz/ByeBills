using System;
using System.Collections.Generic;

#nullable disable

namespace ByeBoletosRepository
{
    public partial class User
    {
        public User()
        {
            Bills = new HashSet<Bill>();
        }

        public string Email { get; set; }
        public string Username { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }

        public virtual ICollection<Bill> Bills { get; set; }
    }
}
