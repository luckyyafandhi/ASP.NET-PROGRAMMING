/* To work eith EPPlus library */
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

namespace ExcelReaderExport.EPPPlus
{
    public static class Reader
    {
        //public static DataTable GetDataTableFromExcel(string path, bool hasHeader = true)
        //{
        //    using (var pck = new OfficeOpenXml.ExcelPackage())
        //    {
        //        using (var stream = File.OpenRead(path))
        //        {
        //            pck.Load(stream);
        //        }
        //        var ws = pck.Workbook.Worksheets.First();
        //        DataTable tbl = new DataTable();
        //        foreach (var firstRowCell in ws.Cells[1, 1, 1, ws.Dimension.End.Column])
        //        {
        //            tbl.Columns.Add(hasHeader ? firstRowCell.Text : string.Format("Column {0}", firstRowCell.Start.Column));
        //        }
        //        var startRow = hasHeader ? 2 : 1;
        //        for (int rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
        //        {
        //            var wsRow = ws.Cells[rowNum, 1, rowNum, ws.Dimension.End.Column];
        //            DataRow row = tbl.Rows.Add();
        //            foreach (var cell in wsRow)
        //            {
        //                row[cell.Start.Column - 1] = cell.Text;
        //            }
        //        }
        //        return tbl;
        //    }
        //}
        public static DataTable GetDataTableFromExcel(Stream stream, bool hasHeader = true)
        {
            using (var pck = new OfficeOpenXml.ExcelPackage())
            {
                pck.Load(stream);
                if(pck.Workbook.Worksheets.Count == 0) { throw new ApplicationException("No Sheet Found !"); }
                var ws = pck.Workbook.Worksheets.First();
                DataTable tbl = new DataTable();
                foreach (var firstRowCell in ws.Cells[1, 1, 1, ws.Dimension.End.Column])
                {
                    tbl.Columns.Add(hasHeader ? firstRowCell.Text : string.Format("Column {0}", firstRowCell.Start.Column));
                }
                var startRow = hasHeader ? 2 : 1;
                for (int rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
                {
                    var wsRow = ws.Cells[rowNum, 1, rowNum, ws.Dimension.End.Column];
                    DataRow row = tbl.Rows.Add();
                    foreach (var cell in wsRow)
                    {
                        int Index = cell.Start.Column - 1;
                        if (Index < tbl.Columns.Count)
                        {
                            row[Index] = cell.Text;
                        }
                       
                    }
                }
                return tbl;
            }
        }
        public static DataTable GetListToDataTableFromExcel(string path, bool hasHeader = true)
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
        public static DataTable ConvertListToDataTable(List<VariableClass> Data)
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

        public static void DataTableToExcel(DataTable CurrentData)
        {
            using (ExcelPackage pck = new ExcelPackage())
            {
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Accounts");
                ws.Cells["A1"].LoadFromDataTable(CurrentData, true);
                HttpContext.Current.Response.BinaryWrite(pck.GetAsByteArray());
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;  filename=Sample2.xlsx");
            }
        }
        public static void ExportExcel(DataTable ds, string FileName, string TypeProcess)
        {

            using (ExcelPackage pck = new ExcelPackage())
            {
                //Create the worksheet
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("SearchReport");

                //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1
                ws.Cells["A1"].LoadFromDataTable(ds, true);

                //prepare the range for the column headers
                //string cellRange = "A1:" + Convert.ToChar('A' + ds.Columns.Count - 1) + 1;
                string cellRange = "A1:" + GetExcelColumnName(ds.Columns.Count) + 1;
                //Format the header for columns
                using (ExcelRange rng = ws.Cells[cellRange])
                {
                    rng.Style.WrapText = true;
                    rng.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid; //Set Pattern for the background to Solid
                    rng.Style.Fill.BackgroundColor.SetColor(Color.Gray);
                    rng.Style.Font.Color.SetColor(Color.White);
                }

                //prepare the range for the rows
                //string rowsCellRange = "A2:" + Convert.ToChar('A' + ds.Columns.Count - 1) + ds.Rows.Count * ds.Columns.Count;
                string rowsCellRange = "A2:" + GetExcelColumnName(ds.Columns.Count) + ds.Rows.Count * ds.Columns.Count;
                //Format the rows
                using (ExcelRange rng = ws.Cells[rowsCellRange])
                {
                    rng.Style.WrapText = false;
                    rng.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                }
                foreach(DataColumn col in ds.Columns)
                {
                    if(col.DataType == System.Type.GetType("System.DateTime"))
                    {
                        int Index = col.Ordinal+1;
                        ws.Column(Index).Style.Numberformat.Format = "dd / MMMM / yyyy";
                    }
                    else if (col.DataType == System.Type.GetType("System.Decimal"))
                    {
                        int Index = col.Ordinal + 1;
                        ws.Column(Index).Style.Numberformat.Format = "#,##0.00";
                    }
                }
                //change cell color depending on the text input from stored proc?
                if (TypeProcess == "MMD")
                {
                    for (var i = 0; i < ds.Rows.Count; i++)
                    {
                        if (ds.Rows[i]["Maturity_Date_Match?"].ToString() == "False")
                        {
                            int IndexResultMaturityDate = ds.Columns["Maturity_Date_Match?"].Ordinal + 1;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.Red);
                        }
                        if (ds.Rows[i]["Tenor_Match?"].ToString() == "False")
                        {
                            int IndexResultMaturityDate = ds.Columns["Tenor_Match?"].Ordinal + 1;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.Red);
                        }
                        if (ds.Rows[i]["CCY_Match?"].ToString() == "False")
                        {
                            int IndexResultMaturityDate = ds.Columns["CCY_Match?"].Ordinal + 1;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.Red);
                        }
                        if (ds.Rows[i]["BAL_AMT_Match?"].ToString() == "False")
                        {
                            int IndexResultMaturityDate = ds.Columns["BAL_AMT_Match?"].Ordinal + 1;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.Red);
                        }
                        if (ds.Rows[i]["Value_Date_Match?"].ToString() == "False")
                        {
                            int IndexResultMaturityDate = ds.Columns["Value_Date_Match?"].Ordinal + 1;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.Red);
                        }
                        if (ds.Rows[i]["Maturity_Date_Match?"].ToString() == "False")
                        {
                            int IndexResultMaturityDate = ds.Columns["Maturity_Date_Match?"].Ordinal + 1;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.Red);
                        }
                        if (ds.Rows[i]["Interest_Rate_Match?"].ToString() == "False")
                        {
                            int IndexResultMaturityDate = ds.Columns["Interest_Rate_Match?"].Ordinal + 1;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.Red);
                        }
                        if (ds.Rows[i]["CIF_Match?"].ToString() == "False")
                        {
                            int IndexResultMaturityDate = ds.Columns["CIF_Match?"].Ordinal + 1;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                            ws.Cells[i + 2, IndexResultMaturityDate].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.Red);
                        }
                    } 
                }
                //int IndexValueDate = ds.Columns["VALUE_DATE"].Ordinal+1;
                //ws.Column(IndexValueDate).Style.Numberformat.Format = "dd - MMMM - yyyy";
                //int IndexMaturityDate = ds.Columns["MATURITY_DATE"].Ordinal+1;
                //ws.Column(IndexMaturityDate).Style.Numberformat.Format = "dd - MMMM - yyyy";

                ws.Cells[ws.Dimension.Address].AutoFitColumns();
                //Read the Excel file in a byte array
                Byte[] fileBytes = pck.GetAsByteArray();

                //Clear the response
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ClearContent();
                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.Cookies.Clear();

                //Add the header & other information
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Current.Response.CacheControl = "private";
                HttpContext.Current.Response.Charset = System.Text.UTF8Encoding.UTF8.WebName;
                HttpContext.Current.Response.ContentEncoding = System.Text.UTF8Encoding.UTF8;
                HttpContext.Current.Response.AppendHeader("Content-Length", fileBytes.Length.ToString());
                HttpContext.Current.Response.AppendHeader("Pragma", "cache");
                HttpContext.Current.Response.AppendHeader("Expires", "60");
                HttpContext.Current.Response.AppendHeader("Content-Disposition",
                "attachment; " +
                "filename=\"" + FileName + "\" ");// +
                //"size=" + fileBytes.Length.ToString() + "; " +
                //"creation-date=" + DateTime.Now.ToString("R") + "; " +
                //"modification-date=" + DateTime.Now.ToString("R") + "; " +
                //"read-date=" + DateTime.Now.ToString("R"));
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                //Write it back to the client
                HttpContext.Current.Response.BinaryWrite(fileBytes);
                HttpContext.Current.Response.End();
            }
        }
        private static string GetExcelColumnName(int columnNumber)
        {
            int dividend = columnNumber;
            string columnName = String.Empty;
            int modulo;

            while (dividend > 0)
            {
                modulo = (dividend - 1) % 26;
                columnName = Convert.ToChar(65 + modulo).ToString() + columnName;
                dividend = (int)((dividend - modulo) / 26);
            }

            return columnName;
        }
    }
}
