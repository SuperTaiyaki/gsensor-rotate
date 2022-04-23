class XRandr
  def set_rotation(orientation)
    `xrandr --output eDP1 --rotation #{orientation.to_s}`
  end
end

