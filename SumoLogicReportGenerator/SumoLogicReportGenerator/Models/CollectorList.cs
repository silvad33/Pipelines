using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace SumoLogicReportGenerator.Models
{
    public class CollectorList
    {
        [JsonPropertyName("collectors")]
        public List<Collector> Collectors { get; set; }
    }
}