using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExcelReaderExport.EPPPlus
{
    public class VariableClass : IEquatable<VariableClass>
    {
        public bool Equals(VariableClass other)
        {
            if (other == null) return false;
            return true;
        }
        public string NAME { get; set; }
        public string CARD_ID { get; set; }
        public string NUMBER_CLASS { get; set; }
        public string DATE_CREATED { get; set; }
        //public string CUST_ID { get; set; }
        //public string CUST_TYPE { get; set; }
        //public string BRANCH_CODE { get; set; }
        //public string BU { get; set; }
        //public string SALES_CODE { get; set; }
        //public string SALES_NAME { get; set; }
        //public string ACCT_NO { get; set; }
        //public string CUST_NAME { get; set; }
        //public string PRODUCT { get; set; }
        //public string SCHM_CODE { get; set; }
        //public string CCY { get; set; }
        //public string BAL_AMT { get; set; }
        //public string RATE { get; set; }
        //public string IDR_BAL_AMT { get; set; }
        //public string INTEREST_RATE { get; set; }
        //public string ACCT_OPEN_DATE { get; set; }
        //public string VALUE_DATE { get; set; }
        //public string MATURITY_DATE { get; set; }
        //public string TENOR { get; set; }
        //public string CODE1 { get; set; }
        //public string CODE2 { get; set; }
        //public string CODE3 { get; set; }
        //public string FTP_CCY { get; set; }
        //public string TENOR_TYPE { get; set; }
        //public string FTP_DATE { get; set; }
        //public string FTP_TYPE { get; set; }
        //public string FTP_CODE { get; set; }
        //public string DAYS { get; set; }
        //public string AUTO_RENEWAL { get; set; }
        //public string FTP_RATE { get; set; }
        //public string INT_INC { get; set; }
        //public string INT_EXP { get; set; }
        //public string NII_IDR { get; set; }
        //public string CODE4 { get; set; }
    }
}
