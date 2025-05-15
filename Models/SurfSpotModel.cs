// Models\SurfSpotModel.cs

namespace MobileSurfBack.Models
{
    public class SurfSpot
    {
        public int SurfSpotId { get; set; }
        public string Destination { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string? StateCountry { get; set; }
        public byte? DifficultyLevel { get; set; }
        public DateTime? PeakSeasonBegin { get; set; }
        public DateTime? PeakSeasonEnd { get; set; }
        public string? MagicSeaweedLink { get; set; }
        public DateTime? CreatedTime { get; set; }
        public string? GeocodeRaw { get; set; }

        // NEW:
        public List<string> PhotoUrls { get; set; } = new();
        public List<string> BreakTypes { get; set; } = new();
        public List<string> Influencers { get; set; } = new();
    }
}
