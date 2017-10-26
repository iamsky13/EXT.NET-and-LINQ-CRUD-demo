using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class DataAccessCls
    {
        public void InsertProduct(Product product)
        {
            product.ProductID = Guid.NewGuid();
            DBDataContext context = new DBDataContext(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());

            using (context)
            {
                context.Products.InsertOnSubmit(product);
                context.SubmitChanges();
            }
        }

        public void UpdateData(Product product)
        {
            DBDataContext context = new DBDataContext(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());

            using (context)
            {
                Product p = context.Products.SingleOrDefault(x => x.ProductID == product.ProductID);
                p.Name = product.Name;
                p.UnitPrice = product.UnitPrice;
                context.SubmitChanges();
            }
        }
        
    }
}
