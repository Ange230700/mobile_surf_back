namespace mobile_surf_back.models
{
        public class SurfSpot
    {
        public int SurfSpotId { get; set; }
        public string Destination { get; set; }
        public string Address { get; set; }
        public string StateCountry { get; set; }
        public byte? DifficultyLevel { get; set; }
        public DateTime? PeakSeasonBegin { get; set; }
        public DateTime? PeakSeasonEnd { get; set; }
        public string MagicSeaweedLink { get; set; }
        public DateTime? CreatedTime { get; set; }
        public string GeocodeRaw { get; set; }
    }
}