# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'frame_calculator'

class FrameCalculatorTest < Minitest::Test
  def test_strike_frame
    frame_score = FrameCalculator.new('X', '1', '1').result
    assert_equal 10 + 1 + 1, frame_score
  end

  def test_double_strike_frame
    frame_score = FrameCalculator.new('X', 'X', '1').result
    assert_equal 10 + 10 + 1, frame_score
  end

  def test_turkey_frame
    frame_score = FrameCalculator.new('X', 'X', 'X').result
    assert_equal 10 + 10 + 10, frame_score
  end

  def test_spare_frame
    frame_score = FrameCalculator.new('1', '9', '1').result
    assert_equal 1 + 9 + 1, frame_score
  end

  def test_normal_frame
    frame_score = FrameCalculator.new('1', '1', '1').result
    assert_equal 1 + 1, frame_score
  end
end
