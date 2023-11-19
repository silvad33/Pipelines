using System.Data;
using System.Linq;
using ClosedXML.Excel;

namespace SumoLogicReportGenerator.Extensions
{
    public static class DataTableExtensions
    {
        public static void ConvertTableToExcel(this DataTable tblObject, string sheetName, string filePath)
        {
            var workBook = new XLWorkbook();
            workBook.Worksheets.Add(tblObject, sheetName);
            workBook.Worksheets.FirstOrDefault()?.Columns().AdjustToContents();
            workBook.SaveAs(filePath);
        }
    }
}