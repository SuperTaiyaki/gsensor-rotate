class XInput
  def device_list
    `xinput list --name-only`.split("\n")
  end
  def set_rotation(value)
    digitizers = device_list.filter { |name|
      name.start_with? 'Wacom'
    }
    orientation = map_orientation(value)
    digitizers.each do |device|
      set_orientation device, orientation
    end
  end

  def set_orientation(device, value)
    `xinput set-int-prop "#{device}" "Wacom Rotation" 8 #{value}`
    p `echo xinput set-int-prop "#{device}" "Wacom Rotation" 8 #{value}`
  end

  # This is probably wrong
  ORIENTATION_MAP = {normal: 0, inverted: 3, left: 2, right: 1}
  def map_orientation(orientation)
    ORIENTATION_MAP[orientation]
  end
end

