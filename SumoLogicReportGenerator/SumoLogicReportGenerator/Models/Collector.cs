using System;
using System.Text.Json.Serialization;
using SumoLogicReportGenerator.JsonConverters;

namespace SumoLogicReportGenerator.Models
{
    public class Collector
    {
        [JsonPropertyName("id")]
        public long Id { get; set; }

        [JsonPropertyName("name")]
        public string Name { get; set; }

        [JsonPropertyName("description")]
        public string Description { get; set; }

        [JsonPropertyName("timeZone")]
        public string TimeZone { get; set; }

        [JsonPropertyName("ephemeral")]
        public bool Ephemeral { get; set; }

        [JsonPropertyName("sourceSyncMode")]
        public string SourceSyncMode { get; set; }

        [JsonPropertyName("collectorType")]
        public string CollectorType { get; set; }

        [JsonPropertyName("collectorVersion")]
        public string CollectorVersion { get; set; }

        [JsonPropertyName("osVersion")]
        public string OSVersion { get; set; }

        [JsonPropertyName("osName")]
        public string OSName { get; set; }

        [JsonPropertyName("osArch")]
        public string OSArch { get; set; }

        [JsonPropertyName("lastSeenAlive")]
        [JsonConverter(typeof(UnixEpochDateTimeConverter))]
        public DateTime LastSeenAlive { get; set; }

        [JsonPropertyName("alive")]
        public bool Alive { get; set; }
    }
}