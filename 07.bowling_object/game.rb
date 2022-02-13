# frozen_string_literal: true

require_relative 'frame_calculator'

class Game
  def initialize(mark_text)
    @marks = mark_text.split(',')
    @frame_calculators = build_frame_caluculators
  end

  def result
    @frame_calculators.map(&:result).sum
  end

  private

  def build_frame_caluculators
    Array.new(10) do
      frame_calculator = FrameCalculator.new(*@marks.slice(0, 3))
      frame_calculator.strike? ? @marks.shift : @marks.shift(2)
      frame_calculator
    end
  end
end
