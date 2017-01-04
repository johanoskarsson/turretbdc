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

# Known issues

This has only been tested with mils and the metric system.
