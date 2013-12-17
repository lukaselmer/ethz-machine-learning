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
       //     Console.WriteLine(Preprocessor.LevenshteinDistance("ckjyjljnehbycrbv", "ckjyjljnthbycrbv"));

            var wp = new WordPrinter();

            var data = Helper.ReadFile("../../../../../../../data/3/corrected_training.csv");
            var levenList = Preprocessor.BuildLevenList(data);
            data = Preprocessor.Filter(data, levenList);

            var wordList = wp.PrintTopWords(data, "../../../../wordlist.txt");
            //var wordList = File.ReadAllLines("../../../../wordlist.txt");
            Helper.WriteXMatrix(data, wordList, "../../../../X_training.txt");
            Helper.WriteYMatix(data, "../../../../Y_training.txt");
            Helper.WriteClassesMatix(data, "../../../../classes.txt");
            Helper.WriteOverride(data, "../../../../override_training.txt");
           // return;
            data = Helper.ReadFile("../../../../../../../data/3/corrected_validation.csv");
            data = Preprocessor.Filter(data, levenList);
            Helper.WriteXMatrix(data, wordList, "../../../../X_validation.txt");
            Helper.WriteOverride(data, "../../../../override_validation.txt");

            data = Helper.ReadFile("../../../../../../../data/3/corrected_testing.csv");
            data = Preprocessor.Filter(data, levenList);
            Helper.WriteXMatrix(data, wordList, "../../../../X_testing.txt");
            Helper.WriteOverride(data, "../../../../override_testing.txt");
        }

    }

    class InEntry
    {
        public string Text { get; set; }
        public int Plz { get; set; }
        public int Country { get; set; }
    }
}
