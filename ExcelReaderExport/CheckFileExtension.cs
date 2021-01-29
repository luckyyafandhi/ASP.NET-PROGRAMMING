using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace ExcelReaderExport
{
    public static class CheckFileExtension
    {
        private static readonly string[] ListAllowedExcelExtension = { ".xls", ".xlsx", ".xlsm"};
        public static bool CheckExcelFileExtension(string Extension)
        {
            if (ListAllowedExcelExtension.Contains(Extension)) { return true; }
            else { return false; }
        }
    }
}
