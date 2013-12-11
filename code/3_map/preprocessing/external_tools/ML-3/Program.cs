using Microsoft.VisualBasic.FileIO;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ML_3
{
    class Program
    {
        static void Main(string[] args)
        {
            
            var wp = new WordPrinter();

            var data = Helper.ReadFile("../../../../../../../data/3/corrected_training.csv");
            data = Preprocessor.Filter(data);

            var wordList = wp.PrintTopWords(data, "../../../../wordlist.txt");
            //var wordList = File.ReadAllLines("../../../../wordlist.txt");
            Helper.WriteXMatrix(data, wordList, "../../../../X_training.txt");
            Helper.WriteYMatix(data, "../../../../Y_training.txt");
            Helper.WriteClassesMatix(data, "../../../../classes.txt");
            Helper.WriteOverride(data, "../../../../override_training.txt");

            data = Helper.ReadFile("../../../../../../../data/3/corrected_validation.csv");
            data = Preprocessor.Filter(data);
            Helper.WriteXMatrix(data, wordList, "../../../../X_validation.txt");
            Helper.WriteOverride(data, "../../../../override_validation.txt");

            data = Helper.ReadFile("../../../../../../../data/3/corrected_testing.csv");
            data = Preprocessor.Filter(data);
            Helper.WriteXMatrix(data, wordList, "../../../../X_testing.txt");
            Helper.WriteOverride(data, "../../../../override_testing.txt");

            //return;
            //var grouped = data.GroupBy(x => x.Plz);
            //var a = grouped.Select(x => new { Plz = x.Key, Stat = GetStat(x) });
            //var b = a.Take(5);
            //foreach (var item in b)
            //{
            //    Console.WriteLine(String.Format("{0}: {1}", item.Plz, item.Stat.Select(x=>String.Format("({0},{1:0.00})", x.Key,x.Value))
            //        .Aggregate((x,y)=>x + ", " + y)));
            //}
            //Console.WriteLine(data.Count());
            //Console.ReadLine();
        }

        private static Dictionary<string, double> GetStat(IGrouping<int, InEntry> group)
        {
            int entryCount = group.Count();
            var allwords = group.SelectMany(x => x.Text.ToLower().Split(' '));
            return allwords.GroupBy(x => x).Select(x => new { Text = x.Key, Count = x.Count() })
                .OrderByDescending(x=>x.Count).Take(10)
                .ToDictionary(x => x.Text, x => (double)x.Count/entryCount);
            throw new NotImplementedException();
        }

        private static IEnumerable<InEntry> ReadFile(string inPath)
        {
            using (TextFieldParser parser = new TextFieldParser(inPath))
            {
                parser.CommentTokens = new string[] { "#" };
                parser.SetDelimiters(new string[] { "," });
                parser.HasFieldsEnclosedInQuotes = true;

                // Skip over header line.
               // parser.ReadLine();

                while (!parser.EndOfData)
                {
                    string[] fields = parser.ReadFields();
                    if (fields.Length == 1)
                    {
                        yield return new InEntry() { Text = fields[0] };
                    }
                    else
                    {
                        yield return new InEntry()
                        {
                            Text = fields[0],
                            Plz = int.Parse(fields[1]),
                            Country = int.Parse(fields[2]),
                        };
                    }
                }
            }
        }
    }

    class InEntry
    {
        public string Text { get; set; }
        public int Plz { get; set; }
        public int Country { get; set; }
    }
}
