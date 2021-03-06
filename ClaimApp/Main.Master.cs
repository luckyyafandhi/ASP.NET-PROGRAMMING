﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClaimApp
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["userName"] != null)
            {
                string loginUserName = Session["userName"].ToString();
                lblLoginUsername.Text = loginUserName;
            }
            else
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            ////setAccess();
            //if ((bool)Session["isSuperAdministrator"] == false)
            //{
            //    linkMaster.Visible = false;
            //    linkSetupBranch.Visible = false;
            //    linkSetupRegion.Visible = false;
            //    linkSetupTerm.Visible = false;
            //    linkSetupJobLevel.Visible = false;
            //    linkSetupGeneral.Visible = false;
            //    linkSetupCategory.Visible = false;
            //    linkSetupEmployeeStatus.Visible = false;
            //    linkSetupMaritalStatus.Visible = false;
            //    linkSetupPremium.Visible = false;
            //    linkSetupPlanSetting.Visible = false;
            //    linkSetupUser2.Visible = false;
            //    linkSetupUser.Visible = false;
            //    LinkUserLogActivity.Visible = false;
            //    //linkset.Visible = false;
            //}
            //if ((bool)Session["isAdministrator"] == false)
            //{
            //    linkSetupUser.Visible = false;
            //    linkMaster.Visible = false;
            //    LinkUserLogActivity.Visible = false;
            //    linkReportUser.Visible = false;
            //}
            //if ((bool)Session["isAdministrator"] == true)
            //{
            //    linkSetupUser.Visible = true;
            //    LinkUserLogActivity.Visible = true;

            //}

            //if ((bool)Session["OnlyViewReport"] == true)
            //{
            //    linkSetupUser.Visible = false;
            //    linkMaster.Visible = false;
            //    LinkUserLogActivity.Visible = false;
            //    linkMaster.Visible = false;
            //    linkSetupBranch.Visible = false;
            //    linkSetupRegion.Visible = false;
            //    linkSetupTerm.Visible = false;
            //    linkSetupJobLevel.Visible = false;
            //    linkSetupGeneral.Visible = false;
            //    linkSetupCategory.Visible = false;
            //    linkSetupEmployeeStatus.Visible = false;
            //    linkSetupMaritalStatus.Visible = false;
            //    linkSetupPremium.Visible = false;
            //    linkSetupPlanSetting.Visible = false;
            //    linkSetupUser2.Visible = false;
            //    linkSetupUser.Visible = false;
            //    LinkUserLogActivity.Visible = false;
            //    linkNotifikasi.Visible = false;
            //    linkListMember.Visible = false;
            //    linkListMemberNotEffective.Visible = false;
            //    linkTransactions.Visible = false;
            //}



        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void linkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            FormsAuthentication.SignOut();
            Response.Redirect("~/home.aspx");
        }
        //protected void linkChangePassword_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("~/ChangePass.aspx");
        //}
    }
}