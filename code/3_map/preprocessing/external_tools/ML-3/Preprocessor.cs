using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ML_3
{
    class Preprocessor
    {
        internal static List<string> BuildLevenList(IEnumerable<InEntry> data)
        {
            var allwords = data.SelectMany(x => x.Text.ToLower().Split(' '));
            var top100Words = allwords.GroupBy(s => s).OrderByDescending(s => s.Count()).Where(s => s.Key.Length > 4).Take(500);
            var t1000 = top100Words.Select(g => new { Word = g.Key, Count = g.Count() }).ToList();
            List<string> filteredTopWords = new List<string>(200);
            foreach (var word in t1000)
            {
                var replacemnt = filteredTopWords.Find(w => LevenshteinDistance(w, word.Word) <= 1);
                if (replacemnt == null)
                    filteredTopWords.Add(word.Word);
            }

            return filteredTopWords;
        }

        internal static IEnumerable<InEntry> Filter(IEnumerable<InEntry> data, List<string> filteredTopWords)
        {


            // return data;
            foreach (var item in data)
            {
                item.Text = item.Text.ToLower().Replace("\"", "$");
                item.Text = item.Text.Split(' ')
                    .Select(w => filteredTopWords.Find(q => LevenshteinDistance(q, w) <= 1) ?? w) // look if word W can be replaced by a top word, if not return the original word W
                    .Aggregate((x, y) => x + " " + y);
                yield return item;
            }
        }

        internal IEnumerable<InEntry> PreFilter(IEnumerable<InEntry> data)
        {
            return data.OrderBy(e => e.Plz).ToList();
            //return data.Take(100);
            //  return data.GroupBy(d => d.Plz).Take(10).SelectMany(g => g);
        }


        public static int LevenshteinDistance(string s, string t)
        {
            int[,] d = new int[s.Length + 1, t.Length + 1];
            for (int i = 0; i <= s.Length; i++)
                d[i, 0] = i;
            for (int j = 0; j <= t.Length; j++)
                d[0, j] = j;
            for (int j = 1; j <= t.Length; j++)
                for (int i = 1; i <= s.Length; i++)
                    if (s[i - 1] == t[j - 1])
                        d[i, j] = d[i - 1, j - 1];  //no operation
                    else
                        d[i, j] = Math.Min(Math.Min(
                            d[i - 1, j] + 1,    //a deletion
                            d[i, j - 1] + 1),   //an insertion
                            d[i - 1, j - 1] + 1 //a substitution
                            );
            return d[s.Length, t.Length];
        }


    }
}
