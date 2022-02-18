# frozen_string_literal: true

require_relative 'frame_calculator'

class Game
  def initialize(mark_text)
    @marks = mark_text.split(',')
  end

  def result
    first_shot_index = 0
    Array.new(10).sum do
      f = FrameCalculator.new(*@marks.slice(first_shot_index, 3))
      first_shot_index += f.strike? ? 1 : 2
      f.result
    end
  end
end
