namespace SmartSchedulePlanner.Models
{
    public class Chromosome
    {
        public List<Gene> Genes { get; set; }
            = new();

        public double Fitness { get; set; }
    }
}