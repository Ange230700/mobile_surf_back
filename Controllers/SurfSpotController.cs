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
        public ActionResult<List<SurfSpot>> GetAll()
        {
            var spots = new List<SurfSpot>();
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
                    spots.Add(new SurfSpot
                    {
                        SurfSpotId = reader.GetInt32(ordId),
                        Destination = reader.GetString(ordDest),
                        Address = reader.GetString(ordAddr),
                        StateCountry = reader.IsDBNull(ordStateCountry)
                                               ? null
                                               : reader.GetString(ordStateCountry),
                        DifficultyLevel = reader.IsDBNull(ordDifficulty)
                                               ? null
                                               : reader.GetByte(ordDifficulty),
                        PeakSeasonBegin = reader.IsDBNull(ordPeakBegin)
                                               ? null
                                               : reader.GetDateTime(ordPeakBegin),
                        PeakSeasonEnd = reader.IsDBNull(ordPeakEnd)
                                               ? null
                                               : reader.GetDateTime(ordPeakEnd),
                        MagicSeaweedLink = reader.IsDBNull(ordMagicLink)
                                               ? null
                                               : reader.GetString(ordMagicLink),
                        CreatedTime = reader.IsDBNull(ordCreated)
                                               ? null
                                               : reader.GetDateTime(ordCreated),
                        GeocodeRaw = reader.IsDBNull(ordGeocode)
                                               ? null
                                               : reader.GetString(ordGeocode),
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

        // GET api/surfspot/{id}
        [HttpGet("{id}")]
        public ActionResult<SurfSpot> GetById(int id)
        {
            var spot = new SurfSpot();
            using var conn = new MySqlConnection(_connectionString);
            conn.Open();

            // 1) load base spot
            using (var cmd = new MySqlCommand(
                "SELECT * FROM SurfSpot WHERE surf_spot_id = @id", conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                using var reader = cmd.ExecuteReader();
                if (!reader.Read())
                    return NotFound();

                int colId = reader.GetOrdinal("surf_spot_id");
                int colDest = reader.GetOrdinal("destination");
                int colAddr = reader.GetOrdinal("address");
                int colStateCountry = reader.GetOrdinal("state_country");
                int colDifficulty = reader.GetOrdinal("difficulty_level");
                int colPeakBegin = reader.GetOrdinal("peak_season_begin");
                int colPeakEnd = reader.GetOrdinal("peak_season_end");
                int colMagicLink = reader.GetOrdinal("magic_seaweed_link");
                int colCreated = reader.GetOrdinal("created_time");
                int colGeocode = reader.GetOrdinal("geocode_raw");

                spot.SurfSpotId = reader.GetInt32(colId);
                spot.Destination = reader.GetString(colDest);
                spot.Address = reader.GetString(colAddr);
                spot.StateCountry = reader.IsDBNull(colStateCountry)
                                     ? null
                                     : reader.GetString(colStateCountry);
                spot.DifficultyLevel = reader.IsDBNull(colDifficulty)
                                       ? null
                                       : reader.GetByte(colDifficulty);
                spot.PeakSeasonBegin = reader.IsDBNull(colPeakBegin)
                                       ? null
                                       : reader.GetDateTime(colPeakBegin);
                spot.PeakSeasonEnd = reader.IsDBNull(colPeakEnd)
                                       ? null
                                       : reader.GetDateTime(colPeakEnd);
                spot.MagicSeaweedLink = reader.IsDBNull(colMagicLink)
                                        ? null
                                        : reader.GetString(colMagicLink);
                spot.CreatedTime = reader.IsDBNull(colCreated)
                                   ? null
                                   : reader.GetDateTime(colCreated);
                spot.GeocodeRaw = reader.IsDBNull(colGeocode)
                                        ? null
                                        : reader.GetString(colGeocode);
            }

            // 2) photos
            using (var cmd = new MySqlCommand(
                "SELECT url FROM Photo WHERE surf_spot_id = @id", conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                using var reader = cmd.ExecuteReader();
                while (reader.Read())
                    spot.PhotoUrls.Add(reader.GetString("url"));
            }

            // 3) break types
            using (var cmd = new MySqlCommand(@"
        SELECT bt.surf_break_type_name
          FROM SurfSpot_SurfBreakType ss
          JOIN SurfBreakType bt 
            ON ss.surf_break_type_id = bt.surf_break_type_id
         WHERE ss.surf_spot_id = @id", conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                using var reader = cmd.ExecuteReader();
                while (reader.Read())
                    spot.BreakTypes.Add(reader.GetString("surf_break_type_name"));
            }

            // 4) influencers
            using (var cmd = new MySqlCommand(@"
        SELECT i.influencer_name
          FROM SurfSpot_Influencer si
          JOIN Influencer i 
            ON si.influencer_id = i.influencer_id
         WHERE si.surf_spot_id = @id", conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                using var reader = cmd.ExecuteReader();
                while (reader.Read())
                    spot.Influencers.Add(reader.GetString("influencer_name"));
            }

            return Ok(spot);
        }
    }
}
