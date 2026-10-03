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

            // สร้าง Population
            var population =
                CreatePopulation(subjects, timeSlots);

            // =====================================================
            // Genetic Algorithm
            // =====================================================
            for (int generation = 0;
                 generation < Generations;
                 generation++)
            {
                // คำนวณ Fitness
                foreach (var chromosome in population)
                {
                    chromosome.Fitness =
                        CalculateFitness(
                            chromosome,
                            subjects);
                }

                // Selection
                population = population
                    .OrderByDescending(x => x.Fitness)
                    .Take(PopulationSize / 2)
                    .ToList();

                // Crossover + Mutation
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

            // Fitness รอบสุดท้าย
            foreach (var chromosome in population)
            {
                chromosome.Fitness =
                    CalculateFitness(
                        chromosome,
                        subjects);
            }

            // คืนผลลัพธ์ที่ดีที่สุด
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

                    // ถ้าเกินเวลาสิ้นสุด ไม่สร้าง Slot
                    if (endTime >
                        activity.DailyEndTime)
                    {
                        break;
                    }

                    // =============================================
                    // พักกลางวัน 12:00 - 13:00
                    // =============================================
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
        // สร้าง Population เริ่มต้น
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

                // สร้างลำดับวิชาตาม Weight
                var subjectSequence =
                    CreateWeightedSubjectSequence(
                        subjects,
                        timeSlots.Count);

                // สุ่มตำแหน่งบางส่วน
                subjectSequence =
                    ShuffleSubjectSequence(
                        subjectSequence);

                for (int j = 0;
                     j < timeSlots.Count;
                     j++)
                {
                    var slot =
                        timeSlots[j];

                    chromosome.Genes.Add(
                        new Gene
                        {
                            SubjectName =
                                subjectSequence[j],

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
        // สร้างลำดับวิชาตาม Weight
        // =========================================================
        private List<string> CreateWeightedSubjectSequence(
            List<ActivitySubject> subjects,
            int totalSlots)
        {
            var result =
                new List<string>();

            int totalWeight =
                subjects.Sum(x => x.Weight);

            if (totalWeight <= 0)
            {
                totalWeight = subjects.Count;

                foreach (var subject in subjects)
                {
                    subject.Weight = 1;
                }
            }

            // =====================================================
            // คำนวณจำนวน Slot ของแต่ละวิชา
            // =====================================================
            var allocations =
                new List<(ActivitySubject Subject,
                          int Slots,
                          double Fraction,
                          int Index)>();

            int assignedSlots = 0;

            for (int i = 0;
                 i < subjects.Count;
                 i++)
            {
                var subject = subjects[i];

                double exactSlots =
                    (double)subject.Weight
                    / totalWeight
                    * totalSlots;

                int slots =
                    (int)Math.Floor(exactSlots);

                double fraction =
                    exactSlots - slots;

                allocations.Add(
                    (
                        subject,
                        slots,
                        fraction,
                        i
                    ));

                assignedSlots += slots;
            }

            // =====================================================
            // แจก Slot ที่เหลือให้กับวิชาที่มีเศษมากที่สุด
            // =====================================================
            int remainingSlots =
                totalSlots - assignedSlots;

            var sortedAllocations =
                allocations
                    .OrderByDescending(x => x.Fraction)
                    .ToList();

            for (int i = 0;
                 i < remainingSlots;
                 i++)
            {
                var current =
                    sortedAllocations[
                        i % sortedAllocations.Count];

                int index =
                    allocations.FindIndex(
                        x => x.Index == current.Index);

                var old =
                    allocations[index];

                allocations[index] =
                    (
                        old.Subject,
                        old.Slots + 1,
                        old.Fraction,
                        old.Index
                    );
            }

            // =====================================================
            // สร้าง Sequence
            // =====================================================
            foreach (var allocation in allocations)
            {
                for (int i = 0;
                     i < allocation.Slots;
                     i++)
                {
                    result.Add(
                        allocation.Subject.SubjectName);
                }
            }

            return result;
        }

        // =========================================================
        // Shuffle Sequence
        // =========================================================
        private List<string> ShuffleSubjectSequence(
            List<string> sequence)
        {
            var result =
                sequence.ToList();

            // Fisher-Yates Shuffle
            for (int i = result.Count - 1;
                 i > 0;
                 i--)
            {
                int j =
                    _random.Next(i + 1);

                var temp =
                    result[i];

                result[i] =
                    result[j];

                result[j] =
                    temp;
            }

            // พยายามลดวิชาเดิมติดกัน
            return ImproveSequence(result);
        }

        // =========================================================
        // ปรับ Sequence ไม่ให้วิชาเดิมติดกันมากเกินไป
        // =========================================================
        private List<string> ImproveSequence(
            List<string> sequence)
        {
            for (int i = 1;
                 i < sequence.Count;
                 i++)
            {
                if (sequence[i] != sequence[i - 1])
                {
                    continue;
                }

                // หา Element หลังจากตำแหน่งปัจจุบัน
                for (int j = i + 1;
                     j < sequence.Count;
                     j++)
                {
                    if (sequence[j] != sequence[i - 1])
                    {
                        var temp =
                            sequence[i];

                        sequence[i] =
                            sequence[j];

                        sequence[j] =
                            temp;

                        break;
                    }
                }
            }

            return sequence;
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

            double score = 1000;

            int totalSlots =
                chromosome.Genes.Count;

            // =====================================================
            // 1. ตรวจสอบ Weight
            // =====================================================
            int totalWeight =
                subjects.Sum(x => x.Weight);

            if (totalWeight > 0)
            {
                foreach (var subject in subjects)
                {
                    // จำนวน Slot ที่วิชานี้ได้รับจริง
                    int actualSlots =
                        chromosome.Genes.Count(
                            x =>
                                x.SubjectName ==
                                subject.SubjectName);

                    // เปอร์เซ็นต์ที่ได้จริง
                    double actualPercentage =
                        (double)actualSlots
                        / totalSlots
                        * 100;

                    // เปอร์เซ็นต์ที่ต้องการ
                    double targetPercentage =
                        (double)subject.Weight
                        / totalWeight
                        * 100;

                    // ความแตกต่าง
                    double difference =
                        Math.Abs(
                            actualPercentage
                            - targetPercentage);

                    // ยิ่งใกล้ Weight ยิ่งได้คะแนนสูง
                    score -=
                        difference * 20;
                }
            }

            // =====================================================
            // 2. ตรวจสอบวิชาเดียวกันติดกัน
            // =====================================================
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
                    score -= 30;
                }
            }

            // =====================================================
            // 3. ตรวจสอบวิชาเดียวกันติดกัน 3 Slot ขึ้นไป
            // =====================================================
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
                        score -= 50;
                    }
                }
                else
                {
                    consecutiveCount = 1;
                }
            }

            // =====================================================
            // 4. ให้คะแนนเมื่อมีการกระจายหลายวิชา
            // =====================================================
            int uniqueSubjects =
                chromosome.Genes
                    .Select(x => x.SubjectName)
                    .Distinct()
                    .Count();

            score +=
                uniqueSubjects * 10;

            // =====================================================
            // 5. ตรวจสอบ Time Slot ซ้ำ
            // =====================================================
            int duplicateSlots =
                chromosome.Genes
                    .GroupBy(x => new
                    {
                        x.StudyDate,
                        x.StartTime,
                        x.EndTime
                    })
                    .Count(x => x.Count() > 1);

            // ถ้ามีเวลาซ้ำ ให้ลงโทษหนัก
            score -=
                duplicateSlots * 100;

            // =====================================================
            // 6. ตรวจสอบว่าทุกวิชาที่มี Weight ถูกใช้งาน
            // =====================================================
            foreach (var subject in subjects)
            {
                bool exists =
                    chromosome.Genes.Any(
                        x =>
                            x.SubjectName ==
                            subject.SubjectName);

                if (!exists)
                {
                    // ถ้า Weight มากแต่ไม่มีในตาราง
                    // ลงโทษมากกว่า Weight น้อย
                    score -=
                        subject.Weight * 2;
                }
            }

            // =====================================================
            // 7. ป้องกัน Fitness ติดลบ
            // =====================================================
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

            // Mutation 20%
            if (
                _random.NextDouble()
                >
                MutationRate)
            {
                return;
            }

            // สุ่มตำแหน่ง Gene
            int index =
                _random.Next(
                    chromosome.Genes.Count);

            // เลือกวิชาตาม Weight
            var selectedSubject =
                SelectSubjectByWeight(
                    subjects);

            // เปลี่ยนเฉพาะ Subject
            // Time Slot เดิมยังคงอยู่
            chromosome.Genes[index]
                .SubjectName =
                    selectedSubject.SubjectName;
        }

        // =========================================================
        // เลือกวิชาตาม Weight
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
    }
}