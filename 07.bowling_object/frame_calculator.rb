# frozen_string_literal: true

class FrameCalculator
  def initialize(first_mark, second_mark, third_mark = nil)
    @first_score = score(first_mark)
    @second_score = score(second_mark)
    @third_score = third_mark ? score(third_mark) : 0
    @first_plus_second_score = @first_score + @second_score
  end

  def result
    return @first_plus_second_score if @first_plus_second_score < 10

    @first_plus_second_score + @third_score
  end

  def strike?
    @first_score == 10
  end

  def spare?
    !strike? && @first_plus_second_score == 10
  end

  private

  def score(mark)
    mark == 'X' ? 10 : mark.to_i
  end
end
