using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp2.DAL
{
    internal class Product
    {


        public int Id { get; set; }
        public string ProductName { get; set; }
        public decimal Price { get; set; }
        public uint Quantity { get; set; }
    }
}
