using Ext.Net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using DAL;
using Newtonsoft.Json;
using System.Text;
using Newtonsoft.Json.Linq;

namespace prac1
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!X.IsAjaxRequest)
            {
               Initialise();
            }
        }

        public void Initialise()
        {
            Store1.DataSource = StoreManager.GetCategories();
            Store1.DataBind();

            Store.DataSource = StoreManager.GetProducts();
            Store.DataBind();
        }

        protected void Save_click(object sender, EventArgs e)
        {
            Page.Validate("productGroup");
            if (Page.IsValid)
            { 
                StoreManager storeManager = new StoreManager();
                Product product = new Product();
                //String aakash = editedtext.Text.Trim();
                //String abc = oldValues



                product.CategoryID = new Guid(CategoryComboBox.SelectedItem.Value);
                product.Name = txtName.Text.Trim();
                product.UnitPrice = System.Convert.ToDecimal(txtUnitPrice.Text);
                storeManager.StoreData(product);
                Initialise();
            }

        }

        public void OnAfterEdit(object sender, DirectEventArgs e)
        {
            StoreManager storeManager = new StoreManager();           
            string newValues = e.ExtraParams["new"];           
            Product p = JsonConvert.DeserializeObject<Product>(newValues);
            storeManager.StoreUpdateData(p);
            
        }

        protected void Delete_Click(object obj, DirectEventArgs e)
        {
            string grid1Json = e.ExtraParams["GridData"];
            dynamic data = JArray.Parse(grid1Json);
            Guid Pid = new Guid(data[0].ProductID.ToString());
            StoreManager storeManager = new StoreManager();
            storeManager.StoreDeleteData(Pid);
            Initialise();
        }



    }
}