%w(training validation testing).each{|f|r = []; CSV.foreach("#{f}.csv", quote_char: ";"){|row| r << row}; CSV.open("corrected_#{f}.csv", "wb"){|csv| r.each{|row| csv << row} }}
