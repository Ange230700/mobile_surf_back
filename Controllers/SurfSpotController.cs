// Controllers\SurfSpotController.cs

using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using MobileSurfBack.Models;

namespace MobileSurfBack.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SurfSpotController : ControllerBase
    {
        private const string ColSurfSpotId = "surf_spot_id";

        private readonly string _connectionString;

        public SurfSpotController(IConfiguration configuration)
        {
            _connectionString = $"server={Environment.GetEnvironmentVariable("MYSQL_HOST")};" +
                                      $"database={Environment.GetEnvironmentVariable("MYSQL_DATABASE")};" +
                                      $"user={Environment.GetEnvironmentVariable("MYSQL_USER")};" +
                                      $"password={Environment.GetEnvironmentVariable("MYSQL_PASSWORD")};";
        }

        // GET api/surfspot/all
        [HttpGet("all")]
        public ActionResult<List<SurfSpotDto>> GetAll()
        {
            var spots = new List<SurfSpotDto>();
            using var conn = new MySqlConnection(_connectionString);
            conn.Open();

            // 1) load base spots
            using (var cmd = new MySqlCommand("SELECT * FROM SurfSpot", conn))
            using (var reader = cmd.ExecuteReader())
            {
                // pull all the ordinals up front:
                int ordId = reader.GetOrdinal(ColSurfSpotId);
                int ordDest = reader.GetOrdinal("destination");
                int ordAddr = reader.GetOrdinal("address");
                int ordStateCountry = reader.GetOrdinal("state_country");
                int ordDifficulty = reader.GetOrdinal("difficulty_level");
                int ordPeakBegin = reader.GetOrdinal("peak_season_begin");
                int ordPeakEnd = reader.GetOrdinal("peak_season_end");
                int ordMagicLink = reader.GetOrdinal("magic_seaweed_link");
                int ordCreated = reader.GetOrdinal("created_time");
                int ordGeocode = reader.GetOrdinal("geocode_raw");

                while (reader.Read())
                {
                    spots.Add(new SurfSpotDto
                    {
                        SurfSpotId = reader.GetInt32(ordId),
                        Destination = reader.GetString(ordDest),
                        Address = reader.GetString(ordAddr),
                        StateCountry = reader.IsDBNull(ordStateCountry) ? null : reader.GetString("state_country"),
                        DifficultyLevel = reader.IsDBNull(ordDifficulty) ? reader.GetByte("difficulty_level") : null,
                        PeakSeasonBegin = reader.IsDBNull(ordPeakBegin) ? reader.GetDateTime("peak_season_begin") : null,
                        PeakSeasonEnd = reader.IsDBNull(ordPeakEnd) ? reader.GetDateTime("peak_season_end") : null,
                        MagicSeaweedLink = reader.IsDBNull(ordMagicLink) ? null : reader.GetString("magic_seaweed_link"),
                        CreatedTime = reader.IsDBNull(ordCreated) ? reader.GetDateTime("created_time") : null,
                        GeocodeRaw = reader.IsDBNull(ordGeocode) ? null : reader.GetString("geocode_raw")
                    });
                }
            }

            if (!spots.Any())
                return Ok(spots);

            var idsCsv = string.Join(",", spots.Select(s => s.SurfSpotId));

            // 2) load photos
            var photoBySpot = new Dictionary<int, List<string>>();
            using (var cmd = new MySqlCommand($@"
                SELECT {ColSurfSpotId}, url 
                  FROM Photo 
                 WHERE {ColSurfSpotId} IN ({idsCsv})", conn))
            using (var reader = cmd.ExecuteReader())
                while (reader.Read())
                {
                    var id = reader.GetInt32(ColSurfSpotId);
                    if (!photoBySpot.ContainsKey(id)) photoBySpot[id] = new();
                    photoBySpot[id].Add(reader.GetString("url"));
                }

            // 3) load break-types
            var breakBySpot = new Dictionary<int, List<string>>();
            using (var cmd = new MySqlCommand($@"
                SELECT ss.{ColSurfSpotId}, bt.surf_break_type_name
                  FROM SurfSpot_SurfBreakType ss
                  JOIN SurfBreakType bt ON ss.surf_break_type_id = bt.surf_break_type_id
                 WHERE ss.{ColSurfSpotId} IN ({idsCsv})", conn))
            using (var reader = cmd.ExecuteReader())
                while (reader.Read())
                {
                    var id = reader.GetInt32(ColSurfSpotId);
                    if (!breakBySpot.ContainsKey(id)) breakBySpot[id] = new();
                    breakBySpot[id].Add(reader.GetString("surf_break_type_name"));
                }

            // 4) load influencers
            var inflBySpot = new Dictionary<int, List<string>>();
            using (var cmd = new MySqlCommand($@"
                SELECT si.{ColSurfSpotId}, i.influencer_name
                  FROM SurfSpot_Influencer si
                  JOIN Influencer i ON si.influencer_id = i.influencer_id
                 WHERE si.{ColSurfSpotId} IN ({idsCsv})", conn))
            using (var reader = cmd.ExecuteReader())
                while (reader.Read())
                {
                    var id = reader.GetInt32(ColSurfSpotId);
                    if (!inflBySpot.ContainsKey(id)) inflBySpot[id] = new();
                    inflBySpot[id].Add(reader.GetString("influencer_name"));
                }

            // 5) merge into DTOs
            foreach (var spot in spots)
            {
                if (photoBySpot.TryGetValue(spot.SurfSpotId, out var urls))
                    spot.PhotoUrls = urls;
                if (breakBySpot.TryGetValue(spot.SurfSpotId, out var types))
                    spot.BreakTypes = types;
                if (inflBySpot.TryGetValue(spot.SurfSpotId, out var names))
                    spot.Influencers = names;
            }

            return Ok(spots);
        }
    }
}
