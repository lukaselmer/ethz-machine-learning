using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ML_3
{
    internal class WordPrinter
    {
        internal void PrintWords()
        {
           
        }

        internal IEnumerable<InEntry> PreFilter(IEnumerable<InEntry> data)
        {
            return data.OrderBy(e=>e.Plz).ToList();
            //return data.Take(100);
            return data.GroupBy(d => d.Plz).Take(10).SelectMany(g => g);
        }

        internal void WriteYTable(IEnumerable<InEntry> data, string outPath)
        {
            File.WriteAllLines(outPath, data.Select(x => x.Plz.ToString() + "," + x.Country.ToString()));
         //   File.WriteAllLines("y.txt", data.Select(x => x.Plz.ToString()));
        }
        internal void WriteClassesTable(IEnumerable<InEntry> data, string outPath)
        {
            var cities = data.GroupBy(x => x.Plz);
            var cityCountries = cities.Select(c => c.Key.ToString() + "," + c.GroupBy(e => e.Country).OrderByDescending(g => g.Count()).First().Key.ToString());
            File.WriteAllLines(outPath, cityCountries);
       //     File.WriteAllLines("classes.txt", data.Select(e=>e.Plz.ToString()).Distinct());
        }

        internal IEnumerable<string> PrintTopWords(IEnumerable<InEntry> data, string outPath)
        {
            var grouped = data.GroupBy(x => x.Plz);
            var a = grouped.Select(x => new { Plz = x.Key, Stat = GetStat(x) });
            //a = a.Take(5);
            var topWords = a.SelectMany(x => x.Stat.Keys).Distinct();

           // File.WriteAllLines(outPath, topWords);
            WriteAssingmentTable(data, topWords, outPath);
            return topWords;
        }

        private static Dictionary<string, double> GetStat(IGrouping<int, InEntry> group)
        {
            int entryCount = group.Count();
            var allwords = group.SelectMany(x => x.Text.ToLower().Split(' '));
            return allwords.GroupBy(x => x).Select(x => new { Text = x.Key, Count = x.Count() })
                .OrderByDescending(x => x.Count).Take(10).Where(x => (double)x.Count / entryCount > 0.1)
                .ToDictionary(x => x.Text, x => (double)x.Count / entryCount);
            throw new NotImplementedException();
        }

        internal void PrintAllWords(IEnumerable<InEntry> data)
        {
            var words = data.SelectMany(x => x.Text.ToLower().Split(' ')).Distinct();
            File.WriteAllLines("allwords.txt", words);


            WriteAssingmentTable(data, words,"X.txt");
            
        }

        public void WriteAssingmentTable(IEnumerable<InEntry> data, IEnumerable<String> words, string outPath)
        {
            var wordList = words.ToList();
            var assignedData = data.Select(x => Assign(x.Text.ToLower().Split(' '), wordList));
            var strTab = assignedData.Select(x => x.Select(x2=>x2.ToString()).Aggregate((z, y) => z + ", " + y));
            File.WriteAllLines(outPath, strTab);
        }

        private int[] Assign(String[] sentence, List<String> wordList)
        {
            int[] result = new int[wordList.Count];
            foreach (var word in sentence)
            {
                int index = wordList.FindIndex(w => w == word);
                if (index >= 0)
                    result[index] = 1;
            }
            return result;
        }
    }
}
