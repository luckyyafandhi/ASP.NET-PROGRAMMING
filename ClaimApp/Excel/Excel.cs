using OfficeOpenXml;
using OfficeOpenXml.Drawing;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;

namespace ClaimApp.Excel
{
    public static class Excel
    {
        public static DataTable ExcelPackageToDataTable(string path, bool hasHeader = true)
        {
            using (var pck = new OfficeOpenXml.ExcelPackage())
            {
                using (var stream = File.OpenRead(path))
                {
                    pck.Load(stream);
                }
                var ws = pck.Workbook.Worksheets.First();
                //DataTable tbl = new DataTable();
                string[] ColumnHeaderName = new string[ws.Dimension.End.Column];
                int FirstIndexHeader = 0;
                foreach (var firstRowCell in ws.Cells[1, 1, 1, ws.Dimension.End.Column])
                {
                    ColumnHeaderName[FirstIndexHeader] = firstRowCell.Text;
                    FirstIndexHeader++;
                    //tbl.Columns.Add(hasHeader ? firstRowCell.Text : string.Format("Column {0}", firstRowCell.Start.Column));
                }
                var startRow = hasHeader ? 2 : 1;
                List<VariableClass> lVC = new List<VariableClass>();
                for (int rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
                {
                    var wsRow = ws.Cells[rowNum, 1, rowNum, ws.Dimension.End.Column];
                    //DataRow row = tbl.Rows.Add();
                    VariableClass newVar = new VariableClass();
                    foreach (var cell in wsRow)
                    {
                        int CellNumber = cell.Start.Column - 1;
                        string HeaderName = ColumnHeaderName[CellNumber];
                        PropertyInfo propertyInfo = newVar.GetType().GetProperty(HeaderName);
                        propertyInfo.SetValue(newVar, Convert.ChangeType(cell.Text, propertyInfo.PropertyType), null);
                        //row[cell.Start.Column - 1] = cell.Text;
                    }
                    lVC.Add(newVar);
                }
                return ConvertListToDataTable(lVC);
            }
        }

        private static DataTable ConvertListToDataTable(List<VariableClass> Data)
        {
            PropertyDescriptorCollection properties =
            TypeDescriptor.GetProperties(typeof(VariableClass));
            DataTable table = new DataTable();
            foreach (PropertyDescriptor prop in properties)
                table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            foreach (VariableClass item in Data)
            {
                DataRow row = table.NewRow();
                foreach (PropertyDescriptor prop in properties)
                    row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
                table.Rows.Add(row);
            }
            return table;
        }
    }
}