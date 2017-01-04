class Ballistics

  # distance -> mils
  attr_accessor :windage

  # distance -> mils
  attr_accessor :elevation

  # TODO sorted. no attr.
  attr_accessor :distances

  def initialize
    @distances = []
    @elevation = Hash.new
    @windage = Hash.new
  end

  def add(distance, windage_mils, elevation_mils)
    @distances.push(distance)
    @windage[distance] = windage_mils
    @elevation[distance] = elevation_mils
  end

  def windage_mils(distance)
    return @windage[distance]
  end

  def elevation_mils(distance)
    return @elevation[distance]
  end

end
