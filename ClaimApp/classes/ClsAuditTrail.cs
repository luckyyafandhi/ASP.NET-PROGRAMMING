using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ClaimApp.classes
{
    public class ClsAuditTrail
    {
        public static void SaveAuditTrail(string Module,string Form, string Action, string Remark,string Session)
        {
            try
            {
                string strSql = "insert into AuditTrail (Module,Form,Action,Remark,CreatedBy,CreatedDate) Values";
                strSql += "(@Module,@Form,@Action,@Remark,@CreatedBy,@CreatedDate)";
                #region Connection
                //Connection To Live Database
                //using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ClaimAppConnectionStringLive())))

                //Connection To Development
                using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ReksaAppConnectionString2())))
                #endregion
                {
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@Module", Module);
                    cmd.Parameters.AddWithValue("@Form", Form);
                    cmd.Parameters.AddWithValue("@Action", Action);
                    cmd.Parameters.AddWithValue("@Remark", Remark);
                    cmd.Parameters.AddWithValue("@CreatedBy", Session);
                    cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
        public static void ErrorAuditTrail(string Module, string Action, string Remark, string Session)
        {

        }
        
    }
}