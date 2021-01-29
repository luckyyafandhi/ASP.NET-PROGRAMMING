using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClaimApp.classes;

namespace ClaimApp
{
    public partial class SetupInvestmentType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] == null)
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //long _NewInvestmentTypePid = 0;
            //_NewInvestmentTypePid = ClsInvestment.AddInvestmentType(txtInvestmentTypeDesc.Text.ToUpper(), (bool)chkActive.Value);
            //if (_NewInvestmentTypePid > 0 )
            //{

            //}
        }

        protected void btnSaveYes_Click(object sender, EventArgs e)
        {
            //long _NewInvestmentTypePid = 0;
            //_NewInvestmentTypePid = ClsInvestment.AddInvestmentType(txtInvestmentTypeDesc.Text.ToUpper(), (bool)chkActive.Value);
            //if (_NewInvestmentTypePid > 0)
            //{
            //    btnSaveYes.Visible = false;
            //    btnSaveNo.Visible = false;
            //    popupSave.Text = "Data Jenis Investasi berhasil ditambahkan".ToUpper();
            //    btnSaveClose.Visible = true;
            //}
        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            //btnSaveClose.Visible = false;
            //btnSaveYes.Visible = true;
            //btnSaveNo.Visible = true;
            //popupSave.Text = "Simpan Data?".ToUpper();
            //Response.Redirect("SetupInvestmentType.aspx");
            //Context.ApplicationInstance.CompleteRequest();
        }
    }
}