#!/usr/bin/env ruby
require_relative './xinput'
require_relative './xrandr'
require_relative './gsensor'

orientation = GSensor.new.orientation
p orientation

XRandr.new.set_rotation orientation
XInput.new.set_rotation orientation

# TODO:
# * Do nothing if current rotation matches new rotation
# * Command line options to force a certain rotation
