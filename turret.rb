class Turret
  attr_accessor :height_mm
  attr_accessor :circumference_mm
  attr_accessor :mils_per_turn

  # How many millimeters are there per mil click on the turret?
  def mm_per_mil
    circumference_mm / (mils_per_turn - 1)
  end
end
