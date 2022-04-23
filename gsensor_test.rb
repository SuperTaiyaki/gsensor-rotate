require "minitest/autorun"
require "./gsensor"

class GSensorTest < MiniTest::Test
  def test_straight_down
    sensor = GSensor.new
    Sysfs.stub :raw_sensor, [0, 1_000_000, 0] do
      assert_equal sensor.orientation, GSensor::NORMAL
    end
  end
  def test_straight_up
    sensor = GSensor.new
    Sysfs.stub :raw_sensor, [0, -1_000_000, 0] do
      assert_equal sensor.orientation, GSensor::INVERTED
    end
  end

end

