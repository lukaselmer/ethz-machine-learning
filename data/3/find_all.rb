a=[];b=[];CSV.foreach("corrected_training.csv"){|row| a<<row[1];b<<row[2]};a=a.uniq;b=b.uniq
