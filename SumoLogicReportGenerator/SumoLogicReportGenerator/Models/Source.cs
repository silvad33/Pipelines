using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using SumoLogicReportGenerator.JsonConverters;

namespace SumoLogicReportGenerator.Models
{
    public class Source
    {
        [JsonPropertyName("id")]
        public long Id { get; set; }

        [JsonPropertyName("name")]
        public string Name { get; set; }

        [JsonPropertyName("category")]
        public string Category { get; set; }

        [JsonPropertyName("description")]
        public string Description { get; set; }

        [JsonPropertyName("hostName")]
        public string HostName { get; set; }

        [JsonPropertyName("automaticDateParsing")]
        public bool AutomaticDateParsing { get; set; }

        [JsonPropertyName("multilineProcessingEnabled")]
        public bool MultilineProcessingEnabled { get; set; }

        [JsonPropertyName("forceTimeZone")]
        public bool ForceTimeZone { get; set; }

        [JsonPropertyName("cutoffTimestamp")]
        [JsonConverter(typeof(UnixEpochDateTimeConverter))]
        public DateTime CutoffTimestamp { get; set; }

        [JsonPropertyName("encoding")]
        public string Encoding { get; set; }

        [JsonPropertyName("pathExpression")]
        public string PathExpression { get; set; }

        [JsonPropertyName("sourceType")]
        public string SourceType { get; set; }

        [JsonPropertyName("alive")]
        public bool Alive { get; set; }

        [JsonPropertyName("url")]
        public string Url { get; set; }

        [JsonPropertyName("fields")]
        public Dictionary<string, string> Fields { get; set; }

        [JsonIgnore]
        public string CollectorName { get; set; }

        [JsonIgnore]
        public string CollectorDescription { get; set; }

        [JsonIgnore]
        public DateTime CollectorLastSeenAlive { get; set; }

        [JsonIgnore]
        public string CollectorTimeZone { get; set; }

        [JsonIgnore]
        public string CollectorOSName { get; set; }

        [JsonIgnore]
        public string CollectorOSVersion { get; set; }

        [JsonIgnore]
        public string FieldsString 
        {
            get
            {
                if (Fields?.Any() != true)
                {
                    return "";
                }

                var fields = new StringBuilder("");
                foreach (var field in Fields.OrderBy(x => x.Key))
                {
                    fields.Append($"{field.Key}:{field.Value} | ");
                }

                return fields.ToString()[..(fields.Length - 3)];
            }
        }
    }
}