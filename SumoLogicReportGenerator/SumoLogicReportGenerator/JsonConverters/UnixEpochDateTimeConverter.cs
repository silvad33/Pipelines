using System;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace SumoLogicReportGenerator.JsonConverters
{
    public class UnixEpochDateTimeConverter : JsonConverter<DateTime>
    {
        public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            var epoch = reader.GetInt64();
            var dateTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
            return dateTime.AddMilliseconds(epoch).ToLocalTime();
        }

        public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options)
        {
        }
    }
}