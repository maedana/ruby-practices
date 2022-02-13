# frozen_string_literal: true

require_relative 'frame_calculator'

class Game
  def initialize(mark_text)
    @marks = mark_text.split(',')
  end

  def result
    Array.new(10).sum do
      f = FrameCalculator.new(*@marks.slice(0, 3))
      f.strike? ? @marks.shift : @marks.shift(2)
      f.result
    end
  end
end
