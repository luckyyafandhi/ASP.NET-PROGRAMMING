using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClaimApp
{
    public partial class InvestSell_Data : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] == null)
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            if (Request.QueryString["BuyPid"] == null)
            {
                Response.Redirect("InvestSell.aspx");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (Convert.ToDouble(Request.QueryString["SisaUnit"].ToString()) == 0D)
            {
                double _Sisa = 0;
                txtSisaUnit.Text = _Sisa.ToString();
               
            }
            else
            {
                txtSisaUnit.Text = Request.QueryString["SisaUnit"].ToString();
            }
            
        }
        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
            Context.ApplicationInstance.CompleteRequest();
        }

        protected void btnSaveYes_Click(object sender, EventArgs e)
        {
            lblSuccess.Visible = false;
            lblError.Visible = false;

            string _TransNumb = string.Empty;
            long _SellPid = 0, _BuyPid = 0;
            _BuyPid = Convert.ToInt64(Request.QueryString["BuyPid"]);


            if (ClsTransactions.createNewSeqNo("Sell", ref _TransNumb))
            {
                try
                {
                    _SellPid = ClsTransactions.addSellTransaction(_TransNumb, _BuyPid, Convert.ToInt64(cboCurrency.Value), Convert.ToInt64(cboKurs.Value), Convert.ToInt64(cboPrice.Value), Convert.ToDouble(txtUnit.Text), Session["userName"].ToString(), (DateTime)txtTglJual.Value, Convert.ToDouble(txtRate.Text));
                }
                catch (SqlException ex)
                {
                    classes.ClsMain.saveErrorLog("InvestSell_Data.aspx : btnSaveYes_Click : " + ex.ToString());
                    lblErrorText.InnerText = "Gagal Menyimpan Transaksi Penjualan, Harap Hubungi Administrator";
                    lblError.Visible = true;
                    return;
                }
                finally
                {
                }
            }

            if (_SellPid > 0)
            {
                lblSuccessText.InnerHtml = "Transaksi Penjualan Berhasil Disimpan";
                lblSuccess.Visible = true;
                bfl1.Enabled = false;
                Context.ApplicationInstance.CompleteRequest();

            }
            else
            {
                lblErrorText.InnerText = "Gagal Menyimpan Transaksi Penjualan, Harap Hubungi Administrator";
                lblError.Visible = true;
                return;
            }
        }

        protected void txtUnit_TextChanged(object sender, EventArgs e)
        {
            if(Convert.ToDouble(txtUnit.Text) > Convert.ToDouble(txtSisaUnit.Text))
            {
                lblErrorText.InnerText = "Total Unit yang dijual melebihi sisa unit yang tersedia, mohon periksa kembali";
                lblError.Visible = true;
                popupSave.ShowOnPageLoad = false;
                return;
            }
            else if (Convert.ToDouble(txtUnit.Text) <= 0)
            {
                lblErrorText.InnerText = "Total Unit tidak boleh 0, mohon periksa kembali";
                lblError.Visible = true;
                popupSave.ShowOnPageLoad = false;
                return;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Convert.ToDouble(txtUnit.Text) > Convert.ToDouble(txtSisaUnit.Text))
            {
                lblErrorText.InnerText = "Total Unit yang dijual melebihi sisa unit yang tersedia, mohon periksa kembali";
                lblError.Visible = true;
                popupSave.ShowOnPageLoad = false;
                return;
            }
            else if (Convert.ToDouble(txtUnit.Text) <= 0)
            {
                lblErrorText.InnerText = "Total Unit tidak boleh 0, mohon periksa kembali";
                lblError.Visible = true;
                popupSave.ShowOnPageLoad = false;
                return;
            }
        }
    }
}