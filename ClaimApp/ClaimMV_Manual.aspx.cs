using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.Configuration;
using System.IO;
using System.Data;
using Upload = ClaimApp.classes.ClsUpload;
using System.Threading;
using ClaimApp.classes;

namespace ClaimApp
{
    public partial class ClaimManual : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] == null)
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
            }
            
        }

        protected void btNew_Click(object sender, EventArgs e)
        {
            
            Response.Redirect("ClaimMV_ManualData.aspx");
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}