using SmartSchedulePlanner.Models;

namespace SmartSchedulePlanner.Services
{
    public class GeneticAlgorithmService
    {
        private readonly Random _random = new();

        private const int PopulationSize = 50;
        private const int Generations = 100;
        private const double MutationRate = 0.20;

        // =========================================================
        // Generate ตารางด้วย Genetic Algorithm
        // =========================================================
        public Chromosome Generate(
            StudyActivity activity,
            List<ActivitySubject> subjects)
        {
            if (subjects == null || subjects.Count == 0)
            {
                return new Chromosome();
            }

            // สร้าง Time Slot ทั้งหมด
            var timeSlots = CreateTimeSlots(activity);

            if (timeSlots.Count == 0)
            {
                return new Chromosome();
            }

            // สร้างประชากรเริ่มต้น
            var population = CreatePopulation(
                subjects,
                timeSlots);

            // Genetic Algorithm
            for (int generation = 0;
                 generation < Generations;
                 generation++)
            {
                // -----------------------------
                // Fitness
                // -----------------------------
                foreach (var chromosome in population)
                {
                    chromosome.Fitness =
                        CalculateFitness(
                            chromosome,
                            subjects);
                }

                // -----------------------------
                // Selection
                // เลือกครึ่งหนึ่งที่ดีที่สุด
                // -----------------------------
                population = population
                    .OrderByDescending(x => x.Fitness)
                    .Take(PopulationSize / 2)
                    .ToList();

                // -----------------------------
                // Crossover + Mutation
                // -----------------------------
                while (population.Count < PopulationSize)
                {
                    var parent1 =
                        population[
                            _random.Next(population.Count)];

                    var parent2 =
                        population[
                            _random.Next(population.Count)];

                    var child =
                        Crossover(
                            parent1,
                            parent2);

                    Mutate(
                        child,
                        subjects);

                    population.Add(child);
                }
            }

            // คำนวณ Fitness รอบสุดท้าย
            foreach (var chromosome in population)
            {
                chromosome.Fitness =
                    CalculateFitness(
                        chromosome,
                        subjects);
            }

            // คืน Chromosome ที่ดีที่สุด
            return population
                .OrderByDescending(x => x.Fitness)
                .First();
        }

        // =========================================================
        // สร้าง Time Slot
        // =========================================================
        private List<TimeSlot> CreateTimeSlots(
            StudyActivity activity)
        {
            var slots = new List<TimeSlot>();

            DateTime currentDate =
                activity.StartDate.Date;

            while (currentDate <= activity.EndDate.Date)
            {
                TimeSpan currentTime =
                    activity.DailyStartTime;

                while (
                    currentTime <
                    activity.DailyEndTime)
                {
                    TimeSpan endTime =
                        currentTime.Add(
                            TimeSpan.FromHours(1));

                    // ถ้าเกินเวลาสิ้นสุด
                    if (endTime >
                        activity.DailyEndTime)
                    {
                        break;
                    }

                    // ข้ามช่วงพักกลางวัน
                    // 12:00 - 13:00
                    bool isLunch =
                        currentTime <
                            TimeSpan.FromHours(13)
                        &&
                        endTime >
                            TimeSpan.FromHours(12);

                    if (!isLunch)
                    {
                        slots.Add(
                            new TimeSlot
                            {
                                StudyDate =
                                    currentDate,

                                StartTime =
                                    currentTime,

                                EndTime =
                                    endTime
                            });
                    }

                    currentTime = endTime;
                }

                currentDate =
                    currentDate.AddDays(1);
            }

            return slots;
        }

        // =========================================================
        // สร้าง Population
        // =========================================================
        private List<Chromosome> CreatePopulation(
            List<ActivitySubject> subjects,
            List<TimeSlot> timeSlots)
        {
            var population =
                new List<Chromosome>();

            for (int i = 0;
                 i < PopulationSize;
                 i++)
            {
                var chromosome =
                    new Chromosome();

                foreach (var slot in timeSlots)
                {
                    var selectedSubject =
                        SelectSubjectByWeight(
                            subjects);

                    chromosome.Genes.Add(
                        new Gene
                        {
                            SubjectName =
                                selectedSubject.SubjectName,

                            StudyDate =
                                slot.StudyDate,

                            StartTime =
                                slot.StartTime,

                            EndTime =
                                slot.EndTime
                        });
                }

                population.Add(chromosome);
            }

            return population;
        }

        // =========================================================
        // สุ่มวิชาตาม Weight
        // =========================================================
        private ActivitySubject SelectSubjectByWeight(
            List<ActivitySubject> subjects)
        {
            int totalWeight =
                subjects.Sum(x => x.Weight);

            if (totalWeight <= 0)
            {
                return subjects[0];
            }

            int randomValue =
                _random.Next(
                    1,
                    totalWeight + 1);

            int currentWeight = 0;

            foreach (var subject in subjects)
            {
                currentWeight +=
                    subject.Weight;

                if (randomValue <= currentWeight)
                {
                    return subject;
                }
            }

            return subjects.Last();
        }

        // =========================================================
        // Fitness Function
        // =========================================================
        private double CalculateFitness(
            Chromosome chromosome,
            List<ActivitySubject> subjects)
        {
            if (chromosome.Genes.Count == 0)
            {
                return 0;
            }

            double score = 100;

            int totalSlots =
                chromosome.Genes.Count;

            // -----------------------------------------------------
            // 1. ตรวจสอบ Weight
            // -----------------------------------------------------
            foreach (var subject in subjects)
            {
                int actualCount =
                    chromosome.Genes.Count(
                        x =>
                            x.SubjectName ==
                            subject.SubjectName);

                double actualPercentage =
                    (double)actualCount
                    / totalSlots
                    * 100;

                double difference =
                    Math.Abs(
                        actualPercentage
                        - subject.Weight);

                // ยิ่งใกล้ Weight ยิ่งดี
                score -= difference * 0.5;
            }

            // -----------------------------------------------------
            // 2. ห้ามวิชาเดียวกันติดกัน
            // -----------------------------------------------------
            for (int i = 1;
                 i < chromosome.Genes.Count;
                 i++)
            {
                if (
                    chromosome.Genes[i].SubjectName
                    ==
                    chromosome.Genes[i - 1].SubjectName
                )
                {
                    score -= 8;
                }
            }

            // -----------------------------------------------------
            // 3. ถ้าวิชาเดียวกันติดกัน 3 ช่องขึ้นไป
            // ลงโทษเพิ่ม
            // -----------------------------------------------------
            int consecutiveCount = 1;

            for (int i = 1;
                 i < chromosome.Genes.Count;
                 i++)
            {
                if (
                    chromosome.Genes[i].SubjectName
                    ==
                    chromosome.Genes[i - 1].SubjectName
                )
                {
                    consecutiveCount++;

                    if (consecutiveCount >= 3)
                    {
                        score -= 10;
                    }
                }
                else
                {
                    consecutiveCount = 1;
                }
            }

            // -----------------------------------------------------
            // 4. ให้คะแนนถ้ามีการกระจายวิชา
            // -----------------------------------------------------
            var uniqueSubjects =
                chromosome.Genes
                    .Select(x => x.SubjectName)
                    .Distinct()
                    .Count();

            score +=
                uniqueSubjects * 2;

            // -----------------------------------------------------
            // ป้องกัน Fitness ติดลบ
            // -----------------------------------------------------
            if (score < 0)
            {
                score = 0;
            }

            return score;
        }

        // =========================================================
        // Crossover
        // =========================================================
        private Chromosome Crossover(
            Chromosome parent1,
            Chromosome parent2)
        {
            var child =
                new Chromosome();

            if (parent1.Genes.Count == 0)
            {
                return child;
            }

            int split =
                _random.Next(
                    1,
                    parent1.Genes.Count);

            for (int i = 0;
                 i < parent1.Genes.Count;
                 i++)
            {
                Gene source;

                if (i < split)
                {
                    source =
                        parent1.Genes[i];
                }
                else
                {
                    source =
                        parent2.Genes[i];
                }

                child.Genes.Add(
                    new Gene
                    {
                        SubjectName =
                            source.SubjectName,

                        StudyDate =
                            source.StudyDate,

                        StartTime =
                            source.StartTime,

                        EndTime =
                            source.EndTime
                    });
            }

            return child;
        }

        // =========================================================
        // Mutation
        // =========================================================
        private void Mutate(
            Chromosome chromosome,
            List<ActivitySubject> subjects)
        {
            if (
                chromosome.Genes.Count == 0
                ||
                subjects.Count == 0)
            {
                return;
            }

            // โอกาส Mutation 20%
            if (
                _random.NextDouble()
                >
                MutationRate)
            {
                return;
            }

            // เลือก Gene แบบสุ่ม
            int index =
                _random.Next(
                    chromosome.Genes.Count);

            // เลือกวิชาใหม่ตาม Weight
            var selectedSubject =
                SelectSubjectByWeight(
                    subjects);

            // เปลี่ยนเฉพาะวิชา
            // วันและเวลาของ Slot เดิมจะไม่เปลี่ยน
            chromosome.Genes[index]
                .SubjectName =
                    selectedSubject.SubjectName;
        }
    }
}