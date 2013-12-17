using Microsoft.VisualBasic.FileIO;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ML_3
{
    internal static class Helper
    {
        public static IEnumerable<InEntry> ReadFile(string inPath)
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
                        yield return new InEntry() { Text = ConvertField0(fields[0]) };
                    }
                    else
                    {
                        yield return new InEntry()
                        {
                            Text = ConvertField0(fields[0]),
                            Plz = int.Parse(fields[1]),
                            Country = int.Parse(fields[2]),
                        };
                    }
                }
            }
        }

        private static string ConvertField0(string field)
        {
            return field.Split(' ').Select(x => x).Aggregate((x, y) => x + " " + y);
        }

        public static void WriteYMatix(IEnumerable<InEntry> data, string outPath)
        {
            File.WriteAllLines(outPath, data.Select(x => x.Plz.ToString() + "," + x.Country.ToString()));
        }

        public static void WriteClassesMatix(IEnumerable<InEntry> data, string outPath)
        {
            var cities = data.GroupBy(x => x.Plz);
            var cityCountries = cities.Select(c => c.Key.ToString() + "," + c.GroupBy(e => e.Country).OrderByDescending(g => g.Count()).First().Key.ToString());
            File.WriteAllLines(outPath, cityCountries);
        }

        public static void WriteXMatrix(IEnumerable<InEntry> data, IEnumerable<String> words, string outPath)
        {
            var wordList = words.ToList();
            var assignedData = data.Select(x => MapSentenceToWords(x.Text.ToLower().Split(' '), wordList));
            var strTab = assignedData.Select(x => x.Select(x2 => x2.ToString()).Aggregate((z, y) => z + ", " + y));
            File.WriteAllLines(outPath, strTab);
        }

        private static int[] MapSentenceToWords(String[] sentence, List<String> wordList)
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

        internal static void WriteOverride(IEnumerable<InEntry> data, string outPath)
        {
            List<int> overrides = new List<int>();
            foreach (var item in data)
            {
                //if (item.Text.Contains("rhfcyjzhcrf hfqjyf"))
                //{
                //    overrides.Add(105089);
                //   // if (item.Plz != 105089) throw new Exception("rule is broken");
                //}
                //else
                {
                    overrides.Add(0);
                }
            }
            File.WriteAllLines(outPath, overrides.Select(x => x.ToString()));
        }
    }
}
