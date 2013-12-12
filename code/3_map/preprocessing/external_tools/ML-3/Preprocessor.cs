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

        internal IEnumerable<InEntry> PreFilter(IEnumerable<InEntry> data)
        {
            return data.OrderBy(e => e.Plz).ToList();
            //return data.Take(100);
          //  return data.GroupBy(d => d.Plz).Take(10).SelectMany(g => g);
        }
    }
}
