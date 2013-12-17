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


        internal IEnumerable<string> PrintTopWords(IEnumerable<InEntry> data, string outPath)
        {
            var grouped = data.GroupBy(x => x.Plz);
            var a = grouped.Select(x => new { Plz = x.Key, Stat = GetStat(x) });
            //a = a.Take(5);
            var topWords = a.SelectMany(x => x.Stat.Keys).Distinct().OrderBy(s=>s);

            File.WriteAllLines(outPath, topWords);
            return topWords;
        }

        private static Dictionary<string, double> GetStat(IGrouping<int, InEntry> group)
        {
            int entryCount = group.Count();
            var allwords = group.SelectMany(x => x.Text.ToLower().Split(' '));
            return allwords.GroupBy(x => x).Select(x => new { Text = x.Key, Count = x.Count() })
                .OrderByDescending(x => x.Count)
                .Where(x=>x.Text.Length > 1)
                .Take(25).Where(x => (double)x.Count / entryCount > 0.1)
                .ToDictionary(x => x.Text, x => (double)x.Count / entryCount);
            throw new NotImplementedException();
        }

        internal void PrintAllWords(IEnumerable<InEntry> data)
        {
            var words = data.SelectMany(x => x.Text.ToLower().Split(' ')).Distinct();
            File.WriteAllLines("allwords.txt", words);


  
        }

    }
}
