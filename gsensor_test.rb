require "minitest/autorun"
require "./gsensor"

class GSensorTest < MiniTest::Test
  def test_straight_down
    sensor = GSensor.new
    Sysfs.stub :raw_sensor, [0, 1_000_000, 0] do
      assert_equal sensor.orientation, :normal
    end
  end
  def test_straight_up
    sensor = GSensor.new
    Sysfs.stub :raw_sensor, [0, -1_000_000, 0] do
      assert_equal sensor.orientation, :inverted
    end
  end

  def test_mostly_down
    sensor = GSensor.new
    Sysfs.stub :raw_sensor, [0, 600_000, 400_000] do
      assert_equal sensor.orientation, :normal
    end
    
    Sysfs.stub :raw_sensor, [0, 600_000, -400_000] do
      assert_equal sensor.orientation, :normal
    end
  end

  def test_left
    sensor = GSensor.new
    Sysfs.stub :raw_sensor, [-1_000_000, 0, 0] do
      assert_equal sensor.orientation, :left
    end

    Sysfs.stub :raw_sensor, [-1_000_000, 200_000, -200_000] do
      assert_equal sensor.orientation, :left
    end
  end

  #def test_balanced
  #  sensor = GSensor.new
  #  Sysfs.stub :raw_sensor, [500_000, 500_000, 500_000] do
  #    assert_equal sensor.orientation, :normal
  #  end
  #end
end

