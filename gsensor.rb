
class Sysfs
  BASE_PATH="/sys/bus/iio/devices"

  def initialize
    @path = find_gravity_sensor
  end

  def Sysfs.find_gravity_sensor
    folders = Dir.glob("#{BASE_PATH}/iio*")
    
    folders.each do |folder|
      File.open("#{folder}/name") do |f|
        return folder if f.read.chomp == "gravity"
      end
    end

    return "NOT_FOUND" # Should throw a real exception
  end
  @@path = Sysfs.find_gravity_sensor()

  # x, y, z
  def Sysfs.raw_sensor
    %w"x y z".map do |axis|
      File.open("#{@@path}/in_gravity_#{axis}_raw") do |f|
        f.read # Just throw this away (clear the buffer)
      end

      File.open("#{@@path}/in_gravity_#{axis}_raw") do |f|
        f.read.to_i
      end

    end
  end
end

class GSensor
  # How to define our orientations?
  # Relative to the LCD's native (and therefore platform native) would make sense
  # so NORMAL is camera-up
  # .... I suppose, match it to xrandr after that?
  
  def orientation
    sensor = Sysfs.raw_sensor
    p sensor

    # Determine which axis has the highest magnitude
    # Don't care if the tablet is face-up flat
    sensor[2] = 0
    max = sensor.max_by { |i| i.abs }
    max_axis = sensor.find_index {|k| k == max || k == max * -1}

    # zeroes are annoying. Forcing a re-scan would be an easy workaround
    if max_axis == 1
      if sensor[1] > 0
        return :normal
      else
        return :inverted
      end
    end

    if max_axis == 0
      if sensor[0] > 0
        return :right
      else
        return :left
      end
    end

    # If screen up or screen down, do nothing
    return :normal
    # TODO: Detect drawing mode (propped up, camera down)
    # TODO: detect the keyboard, lock to :normal
  end
end

