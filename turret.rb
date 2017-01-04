class Turret
  attr_accessor :height_mm
  attr_accessor :circumference_mm
  attr_accessor :mils_per_turn

  def mm_per_mil
    # right?
    circumference_mm / (mils_per_turn - 1)
  end
end
