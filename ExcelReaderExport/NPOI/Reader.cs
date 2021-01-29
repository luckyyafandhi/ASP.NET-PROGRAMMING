using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;

namespace ExcelReaderExport.NPOI
{
    public static class Reader
    {
        public static DataTable Excel_To_DataTable(Stream data, int pHojaIndex)
        {
            // --------------------------------- //
            /* REFERENCIAS:
             * NPOI.dll
             * NPOI.OOXML.dll
             * NPOI.OpenXml4Net.dll */
            // --------------------------------- //
            /* USING:
             * using NPOI.SS.UserModel;
             * using NPOI.HSSF.UserModel;
             * using NPOI.XSSF.UserModel; */
            // --------------------------------- //
            //DataTable NewData = new DataTable();
            try
            {
                IWorkbook workbook;  
                ISheet worksheet;
                string first_sheet_name = "";
                workbook = WorkbookFactory.Create(data); 
                worksheet = workbook.GetSheetAt(pHojaIndex); //Sheet Index start from 0
                first_sheet_name = worksheet.SheetName;  //Get sheet name

                DataTable NewData = new DataTable(first_sheet_name);
                NewData.Rows.Clear();
                NewData.Columns.Clear();
                if (worksheet.LastRowNum == 0)
                {
                    return NewData;
                }
                for (int rowIndex = 0; rowIndex <= worksheet.LastRowNum; rowIndex++)
                {
                    DataRow NewRow = null;
                    IRow row = worksheet.GetRow(rowIndex);
                    IRow row2 = null;

                    if (row != null) //null is when the row only contains empty cells 
                    {
                        if (rowIndex > 0) NewRow = NewData.NewRow();

                        foreach (ICell cell in row.Cells)
                        {
                            object cellData = null;
                            string cellType = "";

                            if (rowIndex == 0) 
                            {
                                row2 = worksheet.GetRow(rowIndex + 1); 
                                ICell cell2 = row2.GetCell(cell.ColumnIndex);
                                if(cell2 != null)
                                {
                                    switch (cell2.CellType)
                                    {
                                        case CellType.Boolean: cellType = "System.Boolean"; break;
                                        case CellType.String: cellType = "System.String"; break;
                                        case CellType.Numeric:
                                            if (HSSFDateUtil.IsCellDateFormatted(cell2)) { cellType = "System.DateTime"; }
                                            else { cellType = "System.Double"; }
                                            break;
                                        case CellType.Formula:
                                            switch (cell2.CachedFormulaResultType)
                                            {
                                                case CellType.Boolean: cellType = "System.Boolean"; break;
                                                case CellType.String: cellType = "System.String"; break;
                                                case CellType.Numeric:
                                                    if (HSSFDateUtil.IsCellDateFormatted(cell2)) { cellType = "System.DateTime"; }
                                                    else { cellType = "System.Double"; }
                                                    break;
                                            }
                                            break;
                                        default:
                                            cellType = "System.String"; break;
                                    }
                                }
                                else
                                {
                                    cellType = "System.String"; 
                                }


                                DataColumn NewColumn = new DataColumn(cell.StringCellValue, System.Type.GetType(cellType));
                                NewData.Columns.Add(NewColumn);
                            }
                            else
                            {
                                switch (cell.CellType)
                                {
                                    case CellType.Blank: cellData = DBNull.Value; break;
                                    case CellType.Boolean: cellData = cell.BooleanCellValue; break;
                                    case CellType.String: cellData = cell.StringCellValue; break;
                                    case CellType.Numeric:
                                        if (HSSFDateUtil.IsCellDateFormatted(cell)) { cellData = cell.DateCellValue; }
                                        else { cellData = cell.NumericCellValue; }
                                        break;
                                    case CellType.Formula:
                                        switch (cell.CachedFormulaResultType)
                                        {
                                            case CellType.Blank: cellData = DBNull.Value; break;
                                            case CellType.String: cellData = cell.StringCellValue; break;
                                            case CellType.Boolean: cellData = cell.BooleanCellValue; break;
                                            case CellType.Numeric:
                                                if (HSSFDateUtil.IsCellDateFormatted(cell)) { cellData = cell.DateCellValue; }
                                                else { cellData = cell.NumericCellValue; }
                                                break;
                                        }
                                        break;
                                    default: cellData = cell.StringCellValue; break;
                                }
                                if(cell.ColumnIndex < NewData.Columns.Count) NewRow[cell.ColumnIndex] = cellData;
                            }
                        }
                    }
                    if (rowIndex > 0) NewData.Rows.Add(NewRow);
                }
                NewData.AcceptChanges();
                workbook.Close();
                return NewData;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
