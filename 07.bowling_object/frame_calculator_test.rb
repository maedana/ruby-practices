# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'frame_calculator'

class FrameCalculatorTest < Minitest::Test
  def test_strike
    frame_score = FrameCalculator.new('X', '1', '1').result
    assert_equal 12, frame_score
  end
end
