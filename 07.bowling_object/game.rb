# frozen_string_literal: true

require_relative 'frame_calculator'

class Game
  def initialize(mark_text)
    @marks = mark_text.split(',')
  end

  def result
    Array.new(10).sum do
      frame_calculator = FrameCalculator.new(*@marks.slice(0, 3))
      frame_calculator.strike? ? @marks.shift : @marks.shift(2)
      frame_calculator.result
    end
  end
end
