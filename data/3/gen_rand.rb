require 'csv'

a=[];b=[];CSV.foreach("corrected_training.csv"){|row| a<<row[1];b<<row[2]};a=a.uniq;b=b.uniq

CSV.open("validation.out", "wb") do |out|
  CSV.foreach("corrected_validation.csv") do |r|
    out << [a.sample, b.sample]
  end
end
