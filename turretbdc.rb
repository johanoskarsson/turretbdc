$LOAD_PATH.unshift '.'
require 'turret'
require 'ballistics'
require 'source_applied_ballistics'
require 'bdc_generator'
require 'optparse'

ARGV << '-h' if ARGV.empty?

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: turretbdc.rb [options]"

  opts.on("-c", "--circumference=circumference", Integer, "Circumference of tower in mm (measured where the label goes)") do |c|
    options[:circumference_mm] = c
  end
  opts.on("-t", "--height=height", Integer, "Height of the part of the tower in mm (measured where the label goes)") do |h|
    options[:height_mm] = h
  end
  opts.on("-m", "--mils-per-turn=milsperturn", Integer, "How many mils does one full revolution of the tower have?") do |m|
    options[:mils_per_turn] = m
  end
  opts.on("-i", "--input=input", "Input file (Applied Ballistics output CSV)") do |i|
    options[:input] = i
  end
  opts.on("-o", "--output=output", "Output pdf file") do |o|
    options[:output] = o
  end
  opts.on("-l", "--label=label", "Any arbitrary text you want printed on the label. Useful for rifle/ammo info.") do |l|
    options[:label] = l
  end
  opts.on("-h", "--help", "Show this message") do
   puts opts
   exit
 end
end.parse!

turret = Turret.new
turret.mils_per_turn = options[:mils_per_turn]
turret.circumference_mm = options[:circumference_mm]
turret.height_mm = options[:height_mm]

source = SourceAppliedBallistics.new
ballistics = source.read(options[:input])

gen = BDCGenerator.new
gen.generate_bdc(turret, ballistics, options[:output], options[:label])
