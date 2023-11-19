using System.Collections.Generic;
using System.Data;
using SumoLogicReportGenerator.Models;

namespace SumoLogicReportGenerator.Extensions
{
    public static class SourceListExtensions
    {
        public static DataTable GetDataTable(this List<Source> sources)
        {
            const string collectorName = "Collector Name";
            const string collectorDescription = "Collector Description";
            const string sourceName = "Source Name";
            const string sourceDescription = "Source Description";
            const string sourceType = "Source Type";
            const string collectorLastSeenAlive = "Collector Last Seen Alive";
            const string collectorTimeZone = "Collector Time Zone";
            const string collectorOSName = "Collector OS Name";
            const string collectorOSVersion = "Collector OS Version";
            const string url = "Url";
            const string sourceEncoding = "Source Encoding";
            const string fields = "Fields";

            var datatable = new DataTable();
            datatable.Columns.Add(collectorName);
            datatable.Columns.Add(collectorDescription);
            datatable.Columns.Add(sourceName);
            datatable.Columns.Add(sourceDescription);
            datatable.Columns.Add(sourceType);
            datatable.Columns.Add(collectorLastSeenAlive);
            datatable.Columns.Add(collectorTimeZone);
            datatable.Columns.Add(collectorOSName);
            datatable.Columns.Add(collectorOSVersion);
            datatable.Columns.Add(url);
            datatable.Columns.Add(sourceEncoding);
            datatable.Columns.Add(fields);

            foreach (var source in sources)
            {
                var sourceRow = datatable.NewRow();
                sourceRow[collectorName] = source.CollectorName ?? "";
                sourceRow[collectorDescription] = source.CollectorDescription ?? "";
                sourceRow[sourceName] = source.Name ?? "";
                sourceRow[sourceDescription] = source.Description ?? "";
                sourceRow[sourceType] = source.SourceType ?? "";
                sourceRow[collectorLastSeenAlive] = source.CollectorLastSeenAlive.ToString("s");
                sourceRow[collectorTimeZone] = source.CollectorTimeZone ?? "";
                sourceRow[collectorOSName] = source.CollectorOSName ?? "";
                sourceRow[sourceEncoding] = source.Encoding ?? "";
                sourceRow[url] = source.Url ?? "";

                sourceRow[collectorOSVersion] = !string.IsNullOrEmpty(source.CollectorOSVersion)
                    ? $"v{source.CollectorOSVersion}"
                    : "";

                sourceRow[fields] = source.FieldsString ?? "";

                datatable.Rows.Add(sourceRow);
            }

            return datatable;
        }
    }
}