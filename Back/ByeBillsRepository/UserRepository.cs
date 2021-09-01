using System;
using System.Collections.Generic;
using System.Linq;


namespace ByeBoletosRepository
{
    public class UserRepository
    {
        public void Add(User user)
        {
            using (var db = new ByeBoletosContext())
            {
                db.Users.Add(user);
                db.SaveChanges();
            }
        }

        public User Get(string email, string password)
        {
            using (var db = new ByeBoletosContext())
            {
                return db.Users.FirstOrDefault(x => x.Email == email && x.Password == password);
            }
        }

        public void Remove(string email)
        {
            using (var db = new ByeBoletosContext())
            {
                User user = db.Users.Find(email);
                db.Users.Remove(user);
            }
        }

    }
}
