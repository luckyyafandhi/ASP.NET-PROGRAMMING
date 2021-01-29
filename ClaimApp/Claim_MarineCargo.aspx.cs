using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MarineCargo = ClaimApp.classes.ClsMarineCargo;

namespace ClaimApp
{
    public partial class ClaimApp_MarineCargo : System.Web.UI.Page
    {
        #region Support
        #endregion
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
            Response.Redirect("Claim_MarineCargoData.aspx");
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}