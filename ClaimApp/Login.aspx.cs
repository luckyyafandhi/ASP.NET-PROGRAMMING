using ClaimApp.classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClaimApp
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string _userip = string.Empty;
            GetIpAddress(out _userip);
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            
            ClsUser clsUser = new ClsUser();
            string password = txtPassword.Text.Trim();
            string userID = string.Empty;
            string _UserName = string.Empty;
            string userName = txtEmail.Text.Trim();
            string UserDivision = string.Empty;
            string UserGroup = string.Empty;
            string UserCompany = string.Empty;
            string divcode = string.Empty;


            string returnUrl = (Request.QueryString["ReturnUrl"] != null ? HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]) : "");
            string loginRedirect = clsUser.userLogin(userName, password, ref userID, ref _UserName, ref UserDivision, ref UserGroup, ref UserCompany, ref divcode, returnUrl);
            if (loginRedirect != "")
            {
                Session["userID"] = userID;
                Session["userName"] = _UserName;
                Session["userDivision"] = UserDivision.Trim();
                Session["userGroup"] = UserGroup.Trim();
                Session["userCompany"] = UserCompany.Trim();
                Session["divcode"] = divcode.Trim();
                Response.Redirect(HttpUtility.UrlDecode(loginRedirect));
            }
            else
            {
                //lblError.Visible = true;
                string msg = "WRONG USERNAME / PASSWORD";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Oops...',html: '" + msg + "' });</script>",
                false);
            }

        }

        private void GetIpAddress(out string userip)
        {
            userip = Request.UserHostAddress;
            if (Request.UserHostAddress != null)
            {
                Int64 macinfo = new Int64();
                string macSrc = macinfo.ToString("X");
                if (macSrc == "0")
                {
                    //if (userip == "127.0.0.1")
                    //{
                    //    Response.Write("visited Localhost!");
                    //}
                    //else
                    //{
                        Session["userIP"] = userip;
                    //}
                }
            }
        }
    }
}