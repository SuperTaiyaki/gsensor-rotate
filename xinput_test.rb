require 'minitest/autorun'
require './xinput'

class XInputTest < MiniTest::Test
  def test_device_list
    sut = XInput.new
    sut.stub :device_list, ["Nothing", "Wacom something"] do
      assert_equal sut.set_rotation, ["Wacom something"]
    end
  end
end

