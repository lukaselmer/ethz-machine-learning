﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ML_3
{

    class Preprocessor
    {
        class Hood
        {
            public List<string> words;

            public Hood(string word)
            {
                words = new List<string>();
                words.Add(word);
            }

            public string getAverageWord()
            {
                string best_word = words.First();
                double best_avg = double.PositiveInfinity;

                foreach (var word in words)
                {
                    double sum = 0;
                    foreach (var word2 in words)
                    {
                        sum += EditDistance(word, word2);
                    }
                    double avg = sum / (words.Count - 1);
                    if (avg < best_avg)
                    {
                        best_avg = avg;
                        best_word = word;
                    }
                }

                //return words.First();
                return best_word;
            }

            public bool isInHood(string word)
            {
                foreach (var hood_word in words)
                {
                    if (IsReplacement(word, hood_word))
                    {
                        return true;
                    }
                }
                return false;
            }
        }

        internal static List<string> BuildLevenList(IEnumerable<InEntry> data)
        {
            var allwords = data.SelectMany(x => x.Text.ToLower().Split(' '));
            var top100Words = allwords.GroupBy(s => s).OrderByDescending(s => s.Count()).Where(s => s.Key.Length > 4).Take(400);
            var t1000 = top100Words.Select(g => new { Word = g.Key, Count = g.Count() }).ToList();
            List<string> filteredTopWords = new List<string>(200);

            List<Hood> hoods = new List<Hood>();

            foreach (var word in t1000)
            {
                bool hood_found = false;
                foreach (var hood in hoods)
                {
                    hood_found = hood.isInHood(word.Word);
                    if (hood_found)
                    {
                        hood.words.Add(word.Word);
                        break;
                    }
                }

                if (!hood_found)
                {
                    hoods.Add(new Hood(word.Word));
                }
            }

            foreach (var hood in hoods)
            {
                filteredTopWords.Add(hood.getAverageWord());
            }

            return filteredTopWords;
        }

        private static bool IsReplacement(string w1, string w2)
        {
            var len = Math.Max(w1.Length, w2.Length);
            var levenshteinDistance = EditDistance(w1, w2);
            var percentage = (1.0 - (levenshteinDistance / (double)len));
            if (w2.Length < 10 || w1.Length < 10)
            {
                if (percentage >= 0.75)
                    return true;
            }
            else
            {
                var w1_ = w1.Substring(0, w1.Length - 3);
                var w2_ = w2.Substring(0, w2.Length - 3);
                var len_ = Math.Max(w1_.Length, w2_.Length);
                var levenshteinDistance_ = EditDistance(w1_, w2_);
                var percentage_ = (1.0 - (levenshteinDistance_ / (double)len_));

                if (percentage_ >= 0.75)
                    return true;
            }
            return false;


            //if (len > 10 && percentage >= 0.7)
            //    return true;
            //if (levenshteinDistance <= 2)
            //    return true;

            return false;
        }

        internal static IEnumerable<InEntry> Filter(IEnumerable<InEntry> data, List<string> filteredTopWords)
        {


            // return data;
            foreach (var item in data)
            {
                item.Text = item.Text.ToLower().Replace("\"", "$");
                item.Text = item.Text.Split(' ')
                    .Select(w => filteredTopWords.Find(q => IsReplacement(q, w)) ?? w) // look if word W can be replaced by a top word, if not return the original word W
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


        private static int EditDistance(string original, string modified)
        {
            int len_orig = original.Length;
            int len_diff = modified.Length;

            var matrix = new int[len_orig + 1, len_diff + 1];
            for (int i = 0; i <= len_orig; i++)
                matrix[i, 0] = i;
            for (int j = 0; j <= len_diff; j++)
                matrix[0, j] = j;

            for (int i = 1; i <= len_orig; i++)
            {
                for (int j = 1; j <= len_diff; j++)
                {
                    int cost = modified[j - 1] == original[i - 1] ? 0 : 1;
                    var vals = new int[] {
                        matrix[i - 1, j] + 1,
                        matrix[i, j - 1] + 1,
                        matrix[i - 1, j - 1] + cost
                    };
                    matrix[i, j] = vals.Min();
                    if (i > 1 && j > 1 && original[i - 1] == modified[j - 2] && original[i - 2] == modified[j - 1])
                        matrix[i, j] = Math.Min(matrix[i, j], matrix[i - 2, j - 2] + cost);
                }
            }
            return matrix[len_orig, len_diff];
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