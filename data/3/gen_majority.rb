require 'csv'

a={}
CSV.foreach("corrected_training.csv") do |row|
  r2 = row[1].to_i
  r1 = row[2].to_i

  a[r2] = {} if a[r2].nil?
  a[r2][r1] = 0 if a[r2][r1].nil?

  a[r2][r1] += 1
end

final = {}

a.each do |plz,v|
  country_most_count = 0
  country_most = nil
  i = 0
  v.each do |country, count|
    i += count
    if country_most_count < count
      country_most_count = count
      country_most = country
    end
  end
  final[plz] = [country_most, country_most_count, i, country_most_count.to_f / i.to_f]
end


CSV.open("plz_country_mapping.out", "wb") do |out|
  out << %w(plz, country, count, total, ratio)
  final.each do |plz, (country, count, total, ratio)|
    out << [plz, country, count, total, ratio]
  end
end
