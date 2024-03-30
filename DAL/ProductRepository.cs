using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp2.DAL
{
    internal class ProductRepository
    {



        string constring;

        public ProductRepository()
        {

            constring = ConfigurationManager.ConnectionStrings["productConnection"].ConnectionString;

        }


        public List<Product> GetProducts()
        {
            List<Product> products = new List<Product>();

            using (SqlConnection con = new SqlConnection(constring))
            {
                var cmd = con.CreateCommand();

                cmd.CommandText = "select * from Products";
                con.Open();

                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    Product product = new Product();

                    product.Id = int.Parse(reader["ProductID"].ToString());
                    product.ProductName = reader["ProductName"].ToString();
                    product.Price = decimal.Parse(reader["UnitPrice"].ToString());
                    product.Quantity = uint.Parse(reader["Quantity"].ToString());

                    products.Add(product);

                }

            }


            return products;
        }

        public List<Product> GetProductsById(int id)
        {

            List<Product> productList = new List<Product>();
            using (SqlConnection con = new SqlConnection(constring))
            {

                var cmd = con.CreateCommand();

                cmd.CommandText = "select * from Products where ProductId = " + id;

                con.Open();


                var reader = cmd.ExecuteReader();






                while (reader.Read())
                {

                    Product product = new Product();


                    product.Id = int.Parse(reader["ProductID"].ToString());
                    product.ProductName = reader["ProductName"].ToString();
                    product.Price = decimal.Parse(reader["UnitPrice"].ToString());
                    product.Quantity = uint.Parse(reader["Quantity"].ToString());

                    productList.Add(product);
                    break;

                }

            }


            return productList;
        }

    }
}
