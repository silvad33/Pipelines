using System;
using System.Collections.Generic;
using System.Text.Json;
using System.Threading;
using RestSharp;
using RestSharp.Authenticators;
using SumoLogicReportGenerator.Extensions;
using SumoLogicReportGenerator.Models;

namespace SumoLogicReportGenerator
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var options = new RestClientOptions
            {
                BaseUrl = new Uri("https://api.sumologic.com/api/v1"),
                Authenticator = new HttpBasicAuthenticator("suEWhQGlPB6lMj", "SSBei8aCdSFG4CiD9IpitCZ9Z5TN8KO6tpwxBRGReY7bLEdetsnoE5Eob2iL9T2I")
            };

            var client = new RestClient(options);

            var collectorRequest = new RestRequest("collectors");
            var collectorJson = client.GetAsync(collectorRequest).Result.Content;
            var collectors = JsonSerializer.Deserialize<CollectorList>(collectorJson);

            if (collectors == null)
            {
                return;
            }

            var sources = new List<Source>();
            foreach (var collector in collectors.Collectors)
            {
                Thread.Sleep(1000);
                Console.WriteLine($"Processing Collector: {collector.Name}");

                var sourceRequest = new RestRequest($"collectors/{collector.Id}/sources");
                var sourceJson = client.GetAsync(sourceRequest).Result.Content;
                if (string.IsNullOrEmpty(sourceJson))
                {
                    continue;
                }

                var sourceResponse = JsonSerializer.Deserialize<SourceList>(sourceJson);
                if (sourceResponse == null)
                {
                    continue;
                }

                foreach (var source in sourceResponse.Sources)
                {
                    source.CollectorName = collector.Name;
                    source.CollectorDescription = collector.Description;
                    source.CollectorLastSeenAlive = collector.LastSeenAlive;
                    source.CollectorTimeZone = collector.TimeZone;
                    source.CollectorOSName = collector.OSName;
                    source.CollectorOSVersion = collector.OSVersion;
                }

                sources.AddRange(sourceResponse.Sources);
            }

            var dataTable = sources.GetDataTable();
            var sortableDate = DateTime.Now.ToString("s").Replace(":", "-");
            dataTable.ConvertTableToExcel("Collectors", $"C:\\temp\\SumoLogicCollectors{sortableDate}.xlsx");
        }
    }
}