using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ML_3
{
    class Preprocessor
    {
        internal static IEnumerable<InEntry> Filter(IEnumerable<InEntry> data)
        {
            foreach (var item in data)
            {
                item.Text = item.Text.ToLower().Replace("\"","");
                yield return item;
            }
        }
    }
}
