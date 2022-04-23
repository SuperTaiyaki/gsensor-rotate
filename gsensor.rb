
class Sysfs
  # x, y, z
  def Sysfs.raw_sensor
    return [1_000_000, 0, 0]
  end
end

class GSensor
  # How to define our orientations?
  # Relative to the LCD's native (and therefore platform native) would make sense
  # so NORMAL is camera-up
  # .... I suppose, match it to xrandr after that?
  
  #TODO these should be labels or something
  NORMAL = 0
  INVERTED = 1

  def orientation
    sensor = Sysfs.raw_sensor

    if sensor[1] > 0
      return NORMAL
    else
      return INVERTED
    end
  end
end

