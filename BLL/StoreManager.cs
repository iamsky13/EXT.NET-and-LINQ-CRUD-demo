using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using System.Configuration;


namespace BLL
{
    public class StoreManager
    {
       // public string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();

        public static List<Category> GetCategories()
        {
            DAL.DBDataContext context = new DAL.DBDataContext(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
            using (context)
            {
                return context.Categories.ToList();
            }
        }

        public static List<Product> GetProducts()
        {
            DAL.DBDataContext context = new DAL.DBDataContext(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
            using (context)
            {
                return context.Products.ToList();
            }
        }

        DataAccessCls dataAccessCls = new DataAccessCls();
        public void StoreData(Product product)
        {
            dataAccessCls.InsertProduct(product);
        }

        public void StoreUpdateData(Product p)
        {
            dataAccessCls.UpdateData(p);
        }

        public void StoreDeleteData(Guid ProductId)
        {
            dataAccessCls.DeleteData(ProductId);
        }
    }

    
}
