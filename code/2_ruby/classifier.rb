class Classifier
  def initialize(input = '../data/2/training.csv')
    require 'csv'
    @x = []
    @y = []

    CSV.foreach(input) do |line|
      l = line.map{|x| Float(x)}
      @y << (l.pop == 1)
      @x << l
    end
  end

  def run
  end
end