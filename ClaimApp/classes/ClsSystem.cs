using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace ClaimApp.classes
{

    public class ClsSystem
    {

        // This constant is used to determine the keysize of the encryption algorithm in bits.
        // We divide this by 8 within the code below to get the equivalent number of bytes.
        private const int Keysize = 256;

        // This constant determines the number of iterations for the password bytes generation function.
        private const int DerivationIterations = 1000;

        public static string MD5Hash(string text)
        {
            MD5 md5 = new MD5CryptoServiceProvider();

            //compute hash from the bytes of text
            md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));

            //get hash result after compute it
            byte[] result = md5.Hash;

            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                //change it into 2 hexadecimal digits
                //for each byte
                strBuilder.Append(result[i].ToString("x2"));
            }

            return strBuilder.ToString();
        }
        public static string Encrypt(string plainText, string passPhrase)
        {
            // Salt and IV is randomly generated each time, but is preprended to encrypted cipher text
            // so that the same Salt and IV values can be used when decrypting.  
            var saltStringBytes = Generate256BitsOfRandomEntropy();
            var ivStringBytes = Generate256BitsOfRandomEntropy();
            var plainTextBytes = Encoding.UTF8.GetBytes(plainText);
            using (var password = new Rfc2898DeriveBytes(passPhrase, saltStringBytes, DerivationIterations))
            {
                var keyBytes = password.GetBytes(Keysize / 8);
                using (var symmetricKey = new RijndaelManaged())
                {
                    symmetricKey.BlockSize = 256;
                    symmetricKey.Mode = CipherMode.CBC;
                    symmetricKey.Padding = PaddingMode.PKCS7;
                    using (var encryptor = symmetricKey.CreateEncryptor(keyBytes, ivStringBytes))
                    {
                        using (var memoryStream = new MemoryStream())
                        {
                            using (var cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write))
                            {
                                cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);
                                cryptoStream.FlushFinalBlock();
                                // Create the final bytes as a concatenation of the random salt bytes, the random iv bytes and the cipher bytes.
                                var cipherTextBytes = saltStringBytes;
                                cipherTextBytes = cipherTextBytes.Concat(ivStringBytes).ToArray();
                                cipherTextBytes = cipherTextBytes.Concat(memoryStream.ToArray()).ToArray();
                                memoryStream.Close();
                                cryptoStream.Close();
                                return Convert.ToBase64String(cipherTextBytes);
                            }
                        }
                    }
                }
            }
        }

        public static string Decrypt(string cipherText, string passPhrase)
        {
            // Get the complete stream of bytes that represent:
            // [32 bytes of Salt] + [32 bytes of IV] + [n bytes of CipherText]
            var cipherTextBytesWithSaltAndIv = Convert.FromBase64String(cipherText);
            // Get the saltbytes by extracting the first 32 bytes from the supplied cipherText bytes.
            var saltStringBytes = cipherTextBytesWithSaltAndIv.Take(Keysize / 8).ToArray();
            // Get the IV bytes by extracting the next 32 bytes from the supplied cipherText bytes.
            var ivStringBytes = cipherTextBytesWithSaltAndIv.Skip(Keysize / 8).Take(Keysize / 8).ToArray();
            // Get the actual cipher text bytes by removing the first 64 bytes from the cipherText string.
            var cipherTextBytes = cipherTextBytesWithSaltAndIv.Skip((Keysize / 8) * 2).Take(cipherTextBytesWithSaltAndIv.Length - ((Keysize / 8) * 2)).ToArray();

            using (var password = new Rfc2898DeriveBytes(passPhrase, saltStringBytes, DerivationIterations))
            {
                var keyBytes = password.GetBytes(Keysize / 8);
                using (var symmetricKey = new RijndaelManaged())
                {
                    symmetricKey.BlockSize = 256;
                    symmetricKey.Mode = CipherMode.CBC;
                    symmetricKey.Padding = PaddingMode.PKCS7;
                    using (var decryptor = symmetricKey.CreateDecryptor(keyBytes, ivStringBytes))
                    {
                        using (var memoryStream = new MemoryStream(cipherTextBytes))
                        {
                            using (var cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read))
                            {
                                var plainTextBytes = new byte[cipherTextBytes.Length];
                                var decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length);
                                memoryStream.Close();
                                cryptoStream.Close();
                                return Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount);
                            }
                        }
                    }
                }
            }
        }

        private static byte[] Generate256BitsOfRandomEntropy()
        {
            var randomBytes = new byte[32]; // 32 Bytes will give us 256 bits.
            using (var rngCsp = new RNGCryptoServiceProvider())
            {
                // Fill the array with cryptographically secure random bytes.
                rngCsp.GetBytes(randomBytes);
            }
            return randomBytes;
        }

        public static string CalculateAge(DateTime Dob)
        {

            //int y, m, d;

            //d = DateTime.Now.Day - Dob.Day;
            //m = DateTime.Now.Month - Dob.Month;
            //y = DateTime.Now.Year - Dob.Year;

            //if (Math.Sign(d) == -1)
            //{
            //    d = 30 - Math.Abs(d);
            //    m -= 1;
            //}

            //if (Math.Sign(m) == -1)
            //{
            //    m = 12 - Math.Abs(m);
            //    y -= 1;
            //}

            //return String.Format("{0} Years {1} Months {2} Days", y, m, d);
            //y + " tahun, " + m + " bulan, " + d + " hari";

            DateTime Now = DateTime.Now;
            int Years = new DateTime(DateTime.Now.Subtract(Dob).Ticks).Year - 1;
            DateTime PastYearDate = Dob.AddYears(Years);
            int Months = 0;
            for (int i = 1; i <= 12; i++)
            {
                if (PastYearDate.AddMonths(i) == Now)
                {
                    Months = i;
                    break;
                }
                else if (PastYearDate.AddMonths(i) >= Now)
                {
                    Months = i - 1;
                    break;
                }
            }
            int Days = Now.Subtract(PastYearDate.AddMonths(Months)).Days;
            int Hours = Now.Subtract(PastYearDate).Hours;
            int Minutes = Now.Subtract(PastYearDate).Minutes;
            int Seconds = Now.Subtract(PastYearDate).Seconds;
            return String.Format("{0} Years {1} Months {2} Days", Years, Months, Days);
        }

        public static Int32 CalculateAgeYears(DateTime Dob)
        {
            DateTime Now = DateTime.Now;
            int Years = new DateTime(DateTime.Now.Subtract(Dob).Ticks).Year - 1;
            DateTime PastYearDate = Dob.AddYears(Years);
            int Months = 0;
            for (int i = 1; i <= 12; i++)
            {
                if (PastYearDate.AddMonths(i) == Now)
                {
                    Months = i;
                    break;
                }
                else if (PastYearDate.AddMonths(i) >= Now)
                {
                    Months = i - 1;
                    break;
                }
            }
            int Days = Now.Subtract(PastYearDate.AddMonths(Months)).Days;
            int Hours = Now.Subtract(PastYearDate).Hours;
            int Minutes = Now.Subtract(PastYearDate).Minutes;
            int Seconds = Now.Subtract(PastYearDate).Seconds;
            return Years;
        }
        //private string CalculateAge(DateTime Dob)
        //{
        //    DateTime Now = DateTime.Now;
        //    int Years = new DateTime(DateTime.Now.Subtract(Dob).Ticks).Year - 1;
        //    DateTime PastYearDate = Dob.AddYears(Years);
        //    int Months = 0;
        //    for (int i = 1; i <= 12; i++)
        //    {
        //        if (PastYearDate.AddMonths(i) == Now)
        //        {
        //            Months = i;
        //            break;
        //        }
        //        else if (PastYearDate.AddMonths(i) >= Now)
        //        {
        //            Months = i - 1;
        //            break;
        //        }
        //    }
        //    int Days = Now.Subtract(PastYearDate.AddMonths(Months)).Days;
        //    int Hours = Now.Subtract(PastYearDate).Hours;
        //    int Minutes = Now.Subtract(PastYearDate).Minutes;
        //    int Seconds = Now.Subtract(PastYearDate).Seconds;
        //    return String.Format("Age: {0} Year(s) {1} Month(s) {2} Day(s) {3} Hour(s) {4} Second(s)",
        //                        Years, Months, Days, Hours, Seconds);
        //}

     


        public static string encryptString(string str)
        {
           
            string encryptPassword = Encrypt(str, CONST.XKEY);
            return encryptPassword;
        }

        public static string DecryptString(string str)
        {

            string DecryptPassword = Decrypt(str, CONST.XKEY);
            return DecryptPassword;
        }

        public static void enumToDataTable(ref DataTable table, Type enumObject)
        {
            table.Rows.Clear();

            foreach(string name in Enum.GetNames(enumObject))
            {
                int i = Convert.ToInt32(Enum.Parse(enumObject, name));
                table.Rows.Add(i, Enum.Parse(enumObject, name).ToString().Replace("_", " "));
            }
        }

        public static Dictionary<string, Dictionary<string, string>> loadSysEnum()
        {
            Dictionary<string, Dictionary<string, string>> result = new Dictionary<string, Dictionary<string, string>>();
            try
            {
                Dictionary<string, string> val;
                string sql = "select * from SysEnum order by EnumName";
                string prevEnumName = string.Empty, enumName = string.Empty, enumKey = string.Empty, enumValue = string.Empty;
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(classes.ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            val = new Dictionary<string, string>();
                            while (dr.Read())
                            {
                                enumName = dr.GetString(dr.GetOrdinal("EnumName"));
                                enumKey = dr.GetString(dr.GetOrdinal("EnumKey"));
                                enumValue = dr.GetString(dr.GetOrdinal("EnumValue"));
                                if (prevEnumName != enumName)
                                {
                                    if (prevEnumName != string.Empty)
                                    {
                                        result.Add(prevEnumName, val);
                                    }

                                    val = new Dictionary<string, string>();
                                    prevEnumName = enumName;
                                }
                                val.Add(enumKey, enumValue);
                            }

                            result.Add(prevEnumName, val);
                        }
                    }
                    catch (SqlException ex)
                    {
                        classes.ClsMain.saveErrorLog(ex.ToString());
                    }
                    finally
                    {
                        if (cmd.Connection.State == System.Data.ConnectionState.Open)
                            cmd.Connection.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }

            return result;
        }

        public static string getEnumKeyByValue(long sysKeypassPID, long sysEnumTypePID, long sysEnumValue)
        {
            string result = string.Empty;

            try
            {
                string sql = "select EnumKey from SysEnum where EnumType_Pid = @enumTypePID and EnumValue = @enumValue";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@enumTypePID", sysEnumTypePID);
                        cmd.Parameters.AddWithValue("@enumValue", sysEnumValue);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if(dr.Read())
                            {
                                result = dr.GetString(dr.GetOrdinal("EnumKey"));
                            }
                        }
                    }
                    catch(SqlException ex)
                    {
                        ClsMain.saveErrorLog(ex.ToString());
                    }
                    finally
                    {
                        if (cmd.Connection.State == ConnectionState.Open)
                            cmd.Connection.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }

            return result;
        }

        public static long getCOBPid(byte sysCOB_PID)
        {
            long result = 0;

            try
            {
                string sql = "select Pid from COB where SysCOB_Id = @sysCOB_PID";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@sysCOB_PID", sysCOB_PID);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if(dr.Read())
                            {
                                result = dr.GetInt64(dr.GetOrdinal("Pid"));
                            }
                        }
                    }
                    catch(Exception ex)
                    {
                        ClsMain.saveErrorLog(ex.ToString());
                    }
                    finally
                    {
                        if (cmd.Connection.State == ConnectionState.Open)
                            cmd.Connection.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }

            return result;
        }

        public static void checkAccess(long sysKeypassPID, long adminUserTypePID, string pageName, ref bool modify, ref bool approve)
        {
            try
            {
                modify = false;
                approve = false;

                string sql = "select t1.Modify, t1.Approve from AdminUserTypeDetail t1 inner join AdminMenu t2 on t1.Menu_Pid = t2.Pid inner join AdminMenuPageName t3 on t2.Pid = t3.AdminMenu_Pid where t1.SysKeypass_Pid = @sysKeypassPID and t1.AdminUserType_Pid = @adminUserTypePID and t3.PageName = @pageName";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@sysKeypassPID", sysKeypassPID);
                        cmd.Parameters.AddWithValue("@adminUserTypePID", adminUserTypePID);
                        cmd.Parameters.AddWithValue("@pageName", pageName);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            while(dr.Read())
                            {
                                modify = dr.GetBoolean(dr.GetOrdinal("Modify"));
                                approve = dr.GetBoolean(dr.GetOrdinal("Approve"));
                            }
                        }
                    }
                    catch(SqlException ex)
                    {
                        classes.ClsMain.saveErrorLog(ex.ToString());
                    }
                    finally
                    {
                        if (cmd.Connection.State == ConnectionState.Open)
                            cmd.Connection.Close();
                    }
                }
            }
            catch(Exception ex)
            {
                ClsMain.saveErrorLog(ex.ToString());
            }
        }

        
    }
}