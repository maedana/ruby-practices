# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'frame_calculator'

class FrameCalculatorTest < Minitest::Test
  def test_strike
    frame_score = FrameCalculator.new('X', '1', '1').result
    assert_equal 10 + 1 + 1, frame_score
  end

  def test_double_strike
    frame_score = FrameCalculator.new('X', 'X', '1').result
    assert_equal 10 + 10 + 1, frame_score
  end

  def test_turkey
    frame_score = FrameCalculator.new('X', 'X', 'X').result
    assert_equal 10 + 10 + 10, frame_score
  end

  def test_spare
    frame_score = FrameCalculator.new('1', '9', '1').result
    assert_equal 1 + 9 + 1, frame_score
  end
end
