require 'csv'

class SourceAppliedBallistics

  COL_DISTANCE = 0
  COL_TIME_OF_FLIGHT = 1
  COL_MACH = 2
  COL_VELOCITY = 3
  COL_ENERGY = 4
  COL_ELEVATION = 5
  COL_WINDAGE = 6
  COL_DROP = 7

  def read(file)
    b = Ballistics.new
    # Range (m), TOF (s), Mach, Velocity (m/s), Energy (J), Elevation (mils), Windage (mils), Drop (inches)
    ballistics = CSV.read(file, headers: :first_row)
    ballistics.each do |row|
      # flipping the elevation to be positive to make calculations easier
      elevation = row[COL_ELEVATION].strip.to_f
      if elevation < 0
        elevation *= -1
      end

      distance = row[COL_DISTANCE].strip.to_i
      # hacky, but we don't care about the crazy short distances
      if distance > 100
        b.add(distance, row[COL_WINDAGE].strip.to_f, elevation)
      end
    end

    return b
  end

end
