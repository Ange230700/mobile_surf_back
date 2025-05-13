using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using mobile_surf_back.models;
using System;
using System.Collections.Generic;

namespace mobile_surf_back.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SurfSpotController : ControllerBase
    {
        [HttpGet]
        [Route("all")]
        public ActionResult<List<SurfSpot>> GetAll()
        {
            string connectionString = "server=localhost;database=mobile_surf;user=root;password=;";
            List<SurfSpot> spots = new List<SurfSpot>();

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM SurfSpot";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        SurfSpot spot = new SurfSpot
                        {
                            SurfSpotId = reader.GetInt32("surf_spot_id"),
                            Destination = reader.GetString("destination"),
                            Address = reader.GetString("address"),
                            StateCountry = reader.IsDBNull(reader.GetOrdinal("state_country")) ? null : reader.GetString("state_country"),
                            DifficultyLevel = reader.IsDBNull(reader.GetOrdinal("difficulty_level")) ? null : (byte?)reader.GetByte("difficulty_level"),
                            PeakSeasonBegin = reader.IsDBNull(reader.GetOrdinal("peak_season_begin")) ? null : (DateTime?)reader.GetDateTime("peak_season_begin"),
                            PeakSeasonEnd = reader.IsDBNull(reader.GetOrdinal("peak_season_end")) ? null : (DateTime?)reader.GetDateTime("peak_season_end"),
                            MagicSeaweedLink = reader.IsDBNull(reader.GetOrdinal("magic_seaweed_link")) ? null : reader.GetString("magic_seaweed_link"),
                            CreatedTime = reader.IsDBNull(reader.GetOrdinal("created_time")) ? null : (DateTime?)reader.GetDateTime("created_time"),
                            GeocodeRaw = reader.IsDBNull(reader.GetOrdinal("geocode_raw")) ? null : reader.GetString("geocode_raw")
                        };
                        spots.Add(spot);
                    }
                }
            }

            return Ok(spots);
        }
    }
}
