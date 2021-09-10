using System;
using System.Collections.Generic;

#nullable disable

namespace ByeBoletosRepository
{
    public partial class Bill
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime Payday { get; set; }
        public double Value { get; set; }
        public string Barcode { get; set; }
        public string Email { get; set; }

        public virtual User EmailNavigation { get; set; }
    }
}
