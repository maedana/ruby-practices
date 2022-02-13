# frozen_string_literal: true

class FrameCalculator
  def initialize(first_mark, second_mark, third_mark)
    @first_mark = first_mark
    @first_score = score(@first_mark)
    @second_mark = second_mark
    @second_score = score(@second_mark)
    @third_mark = third_mark
    @third_score = score(@third_mark)
  end

  def result
    @first_score + @second_score + @third_score
  end

  private

  def score(mark)
    mark == 'X' ? 10 : mark.to_i
  end
end
