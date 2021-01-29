using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ClaimApp.classes
{
    public class ClsReportDetail
    {
        public string GetClientName(string xcode)
        {
            string ClaimName = "";
            DataTable dt = new DataTable();
            string strSql = " select * from POLMain where ClientCode = @ClientCode ";
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ClaimAppConnectionCoreLive())))
                
            //Connection To Development
            using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ReksaAppCoreConnectionString())))
            {
                try
                {
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@ClientCode", xcode);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    cmd.Connection.Close();
                }
                catch (Exception ex)
                {

                    throw ex;
                }
                finally { }
                ClaimName = dt.Rows[0]["ClientName"].ToString().Trim();
                return ClaimName;
            }

        }
        
        
    }
}