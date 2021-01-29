using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExcelReaderExport.EPPPlus
{
    public static class ExcelToCSV
    {
        public static string DuplicateTicksForSql(this string s)
        {
            return s.Replace("'", "''");
        }

        public static string ToDelimitedString(this List<string> list, string delimiter = ":", bool insertSpaces = false, string qualifier = "", bool duplicateTicksForSQL = false)
        {
            var result = new StringBuilder();
            for (int i = 0; i < list.Count; i++)
            {
                string initialStr = duplicateTicksForSQL ? list[i].DuplicateTicksForSql() : list[i];
                result.Append((qualifier == string.Empty) ? initialStr : string.Format("{1}{0}{1}", initialStr, qualifier));
                if (i < list.Count - 1)
                {
                    result.Append(delimiter);
                    if (insertSpaces)
                    {
                        result.Append(' ');
                    }
                }
            }
            return result.ToString();
        }

        public static void MainProgram(string SourFile, string ResultFile)
        {
            var inputFile = new FileInfo(SourFile);

            using (var doc = new ExcelPackage(inputFile))
            {
                Process(doc.Workbook.Worksheets[1], ResultFile);  // everything 1-based in excel.
            }

            Console.WriteLine("done");
        }
        private static void Process(ExcelWorksheet worksheet, string OUT_FILE)
        {
            int maxColumnNumber = worksheet.Dimension.End.Column;
            var currentRow = new List<string>(maxColumnNumber);
            var totalRowCount = worksheet.Dimension.End.Row;
            var currentRowNum = 1;

            /// This will cause OOM for giant file.
            //foreach ( var row in worksheet.Cells.GroupBy( c => c.Start.Row ) )
            //{
            //    ;
            //}

            using (var writer = new StreamWriter(OUT_FILE, false, Encoding.ASCII))
            {
                while (currentRowNum <= totalRowCount)
                {
                    BuildRow(worksheet, currentRow, currentRowNum, maxColumnNumber);
                    WriteRecordToFile(currentRow, writer, currentRowNum, totalRowCount);
                    currentRow.Clear();
                    currentRowNum++;
                }
            }

        }

        private static void WriteRecordToFile(List<string> record, StreamWriter sw, int rowNumber, int totalRowCount)
        {
            var commaDelimitedRecord = record.ToDelimitedString(",");
            /// See FlatFileImporter.ExecuteImport
            if (rowNumber == totalRowCount)
            {
                sw.Write(commaDelimitedRecord);
            }
            else
            {
                sw.WriteLine(commaDelimitedRecord);
            }
        }

        private static void BuildRow(ExcelWorksheet worksheet, List<string> currentRow, int currentRowNum, int maxColumnNumber)
        {
            /// This never comes back for giant worksheet.
            //var cellsForCurrentRow = worksheet.Cells.Where( c => c.Start.Row == currentRowNum );

            /// This just skips blank cells altogether
            //var cellsForCurrentRow = worksheet.Cells[ExcelRange.GetAddress( currentRowNum, 1, currentRowNum, maxColumnNumber )];

            for (int i = 1; i <= maxColumnNumber; i++)
            {
                var cell = worksheet.Cells[currentRowNum, i];
                if (cell == null)
                {
                    /// Add a cell value for empty cells to keep data aligned.
                    AddCellValue(string.Empty, currentRow);
                }
                else
                {
                    AddCellValue(GetCellText(cell), currentRow);
                }
            }
        }

        private static string GetCellText(ExcelRangeBase cell)
        {
            return cell.Value == null ? string.Empty : cell.Value.ToString();
        }

        private static void AddCellValue(string s, List<string> record)
        {
            record.Add(string.Format("{0}{1}{0}", '"', s));
        }

    }
}
