# What's this?

Takes the output of [Applied Ballistics](https://store.appliedballisticsllc.com/ProductDetails.asp?ProductCode=DL2001)
and converts it into a labels suitable for attaching to a scope turret.

This means you can calculate the ballistics for the environment, load and other
variables on the day of a competition, print and attach to the scope.

The program output is a pdf file that can be printed on something like a
DYMO LabelWriter 450.

# Getting started

This is a Ruby program so you need Ruby installed. Below is assuming MacOS and Homebrew is used.

    brew install ruby
    bundle install
    bundle exec ruby turretbdc.rb -h

See example_input.csv for an example of what kind of data the program expects.

# Generating input csv file

1. Click Edit -> Units -> Input -> Metric
2. Pick your bullet from the database. Use Applied Ballistics Custom Drag Curves if available.
3. Enter Muzzle velocity, Zerorange, sight height and twist rate as appropriate
4. Set "Avg. Wind Speed" to 0. Leave spin drift on.
5. Set temperature, pressure and humidity as you have measure or expect it to be when shooting.
6. Set heading to 0.
7. You'll get one mark per entry in the range card, so set increment and max distance to whatever you'd like printed.
8. File -> Export range card

# Known issues

This has only been tested with mils and the metric system.
