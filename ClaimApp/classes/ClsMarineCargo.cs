using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

namespace ClaimApp.classes
{
    public class ClsMarineCargo
    {
        public static string GetMOPNoByCertificateClient(string client, string certificate)
        {
            string result = "";
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionStringDevX()))
                {
                    string strSql = "Select MOPNo from t_tr_MOPCertificate";
                    strSql += " WHERE ClientCode ='" + client + "' and CertificateNo ='" + certificate + "'";
                    using (SqlCommand cmd = new SqlCommand(strSql, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                        connection.Close();
                    }
                }
                result = dt.Rows[0]["MOPNo"].ToString().Trim();
                return result;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public static DataTable getDataConveyence(string mOP)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionStringDevX()))
                {
                    string strSql = "select * from tr_MOPCertificateconv ";
                    strSql += " where MOPNo = '" + mOP + "'";
                    using (SqlCommand cmd = new SqlCommand(strSql, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                        connection.Close();
                    }
                }
                return dt;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}