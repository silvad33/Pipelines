using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace SumoLogicReportGenerator.Models
{
    public class SourceList
    {
        [JsonPropertyName("sources")]
        public List<Source> Sources { get; set; }
    }
}