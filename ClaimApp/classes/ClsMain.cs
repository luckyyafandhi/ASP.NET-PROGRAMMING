﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;

namespace ClaimApp.classes
{
    public class CONST
    {
        public const int COMMAND_TIMEOUT = 600;
        public const string DB_DATEFORMAT = "yyyy-MM-dd";
        public const string DATEFORMAT = "dd-MM-yyyy";
        public const string DATEFORMATDISPLAY = "dd-MMM-yyyy";
        public const string NUMBER_FORMAT = "#,##0";
        public const string XKEY = "NikkOInD0";
    }
    public class ClsMain
    {
        public static string ClaimAppConnectionCoreLive()
        {
            return ConfigurationManager.ConnectionStrings["ClaimAppConnectionCoreLive"].ToString();
        }
        public static string ClaimAppConnectionStringLive()
        {
            return ConfigurationManager.ConnectionStrings["ClaimAppConnectionStringLive"].ToString();
        }
        public static string ReksaAppConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["ReksaAppConnectionString"].ToString();
        }
        public static string ReksaAppConnectionString2()
        {
            return ConfigurationManager.ConnectionStrings["ReksaAppConnectionString2"].ToString();
        }
        public static string ReksaAppConnectionStringDevX()
        {
            return ConfigurationManager.ConnectionStrings["ReksaAppConnectionStringDevX"].ToString();
        }
        public static string ReksaAppCoreConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["ClaimAppConnectionStringCore"].ToString();
        }
        public static string ReksaAppCoreConnectionString2()
        {
            return ConfigurationManager.ConnectionStrings["ReksaAppConnectionStringCore2"].ToString();
        }
        public static string logFolder()
        {
            return ConfigurationManager.AppSettings["logFolder"].ToString();
        }

        public static string uploadFolder()
        {
            return ConfigurationManager.AppSettings["Attachment"].ToString();
        }

        public static string tempFolder()
        {
            return ConfigurationManager.AppSettings["tempFolder"].ToString();
        }
        public static string EmailFolder()
        {
            return ConfigurationManager.AppSettings["EmailFolder"].ToString();
        }

        public static bool isFileExists(String p)
        {
            bool ret = false;
            try
            {
                if (File.Exists(p))
                {
                    ret = true;
                }
            }
            catch (Exception ex) { saveErrorLog("isFileExists: " + ex.ToString()); }
            finally { }
            return ret;
        }

        public static string getDateValue(DateTime dt)
        {
            string ret = string.Format("{0:yyyy-MM-dd}", dt);
            return ret;
        }

        public static string getKeypass()
        {
            return ConfigurationManager.AppSettings["keypass"].ToString();
        }

        public static void saveErrorLog(string perror)
        {
            System.IO.StreamWriter writer;
            try
            {
                string mtoday = string.Format("{0:yyyyMMdd}", System.DateTime.Today);
                string mtime = String.Format("{0:HH:mm:ss}", System.DateTime.Now);
                string sfullname = logFolder() + "\\" + "ErrorClaimApp_" + mtoday + ".log";
                string merror = mtime + ";" + perror;
                if (!File.Exists(sfullname))
                {
                    writer = File.CreateText(sfullname);
                    writer.Close();
                }
                using (StreamWriter sw = File.AppendText(sfullname))
                {
                    sw.WriteLine(merror);
                    sw.Flush();
                    sw.Close();
                }
            }
            catch { }
            finally { }
        }

        public static void saveDebugLog(string perror)
        {
            System.IO.StreamWriter writer;
            try
            {
                string mtoday = string.Format("{0:yyyyMMdd}", System.DateTime.Today);
                string mtime = String.Format("{0:HH:mm:ss}", System.DateTime.Now);
                string sfullname = logFolder() + "\\" + "DebugClaimApp_" + mtoday + ".log";
                string merror = mtime + ";" + perror;
                if (!File.Exists(sfullname))
                {
                    writer = File.CreateText(sfullname);
                    writer.Close();
                }
                using (StreamWriter sw = File.AppendText(sfullname))
                {
                    sw.WriteLine(merror);
                    sw.Flush();
                    sw.Close();
                }
            }
            catch  { }
            finally { }
        }
        
        public static string replaceUnderScoreWithSpace(string text)
        {
            return text.Replace("_", " ");
        }

        public static Type GetClrType(SqlDbType sqlType)
        {
            switch (sqlType)
            {
                case SqlDbType.BigInt:
                    return typeof(long?);

                case SqlDbType.Binary:
                case SqlDbType.Image:
                case SqlDbType.Timestamp:
                case SqlDbType.VarBinary:
                    return typeof(byte[]);

                case SqlDbType.Bit:
                    return typeof(bool?);

                case SqlDbType.Char:
                case SqlDbType.NChar:
                case SqlDbType.NText:
                case SqlDbType.NVarChar:
                case SqlDbType.Text:
                case SqlDbType.VarChar:
                case SqlDbType.Xml:
                    return typeof(string);

                case SqlDbType.DateTime:
                case SqlDbType.SmallDateTime:
                case SqlDbType.Date:
                case SqlDbType.Time:
                case SqlDbType.DateTime2:
                    return typeof(DateTime?);

                case SqlDbType.Decimal:
                case SqlDbType.Money:
                case SqlDbType.SmallMoney:
                    return typeof(decimal?);

                case SqlDbType.Float:
                    return typeof(double?);

                case SqlDbType.Int:
                    return typeof(int?);

                case SqlDbType.Real:
                    return typeof(float?);

                case SqlDbType.UniqueIdentifier:
                    return typeof(Guid?);

                case SqlDbType.SmallInt:
                    return typeof(short?);

                case SqlDbType.TinyInt:
                    return typeof(byte?);

                case SqlDbType.Variant:
                case SqlDbType.Udt:
                    return typeof(object);

                case SqlDbType.Structured:
                    return typeof(DataTable);

                case SqlDbType.DateTimeOffset:
                    return typeof(DateTimeOffset?);

                default:
                    throw new ArgumentOutOfRangeException("sqlType");
            }
        }

        public static string getDate_DMY(DateTime dt)
        {
            string ret = string.Format("{0:dd-MMM-yyyy}", dt);
            return ret;
        }

        public static string getDate_YMD(DateTime dt)
        {
            string ret = string.Format("{0:yyyy-MM-dd}", dt);
            return ret;
        }

        public static string getDate_DMYHMS(DateTime dt)
        {
            string ret = string.Format("{0:dd-MM-yyyy HH:mm:ss}", dt);
            return ret;
        }

        public static string getCurrentDateTime()
        {
            string ret = string.Format("{0:yyyy-MM-dd HH:mm:ss}", Convert.ToDateTime(System.DateTime.Now.ToString()));
            return ret;
        }
        public static DateTime getMinDefaultDate()
        {
            DateTime ret = DateTime.MinValue;
            string minDate = "01-01-1900";
            DateTime.TryParseExact(minDate, CONST.DATEFORMAT, CultureInfo.InvariantCulture, DateTimeStyles.None, out ret);
            return ret;
        }
    }
}