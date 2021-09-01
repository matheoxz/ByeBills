using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ByeBoletosRepository
{
    public class BillRepository
    {
        public void Add(Bill bill)
        {
            using (var db = new ByeBoletosContext())
            {
                db.Bills.Add(bill);
                db.SaveChanges();
            }
        }

        public List<Bill> GetAll(string email)
        {
            using (var db = new ByeBoletosContext())
            {
                return db.Bills.Where(x => x.Email == email).ToList();
            }
        }

        public Bill Get(int id)
        {
            using (var db = new ByeBoletosContext())
            {
                return db.Bills.Find(id);
            }
        }

        public void Update(int id, Bill newBill)
        {
            using (var db = new ByeBoletosContext())
            {
                Bill bill = db.Bills.Find(id);

                bill.Name = newBill.Name;
                bill.Description = newBill.Description;
                bill.Value = newBill.Value;
                bill.Payday = newBill.Payday;
                bill.Barcode = newBill.Barcode;

                db.SaveChanges();
            }
        }

        public void Remove(int id)
        {
            using (var db = new ByeBoletosContext())
            {
                Bill bill = db.Bills.Find(id);
                db.Bills.Remove(bill);
            }
        }
    }
}
