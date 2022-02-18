# frozen_string_literal: true

class FrameCalculator
  STRIKE_SCORE = 10
  STRIKE_MARK = 'X'

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_score = score(first_mark)
    second_score = score(second_mark)
    @third_score = third_mark ? score(third_mark) : 0
    @first_two_score = @first_score + second_score
  end

  def result
    return @first_two_score if @first_two_score < STRIKE_SCORE

    @first_two_score + @third_score
  end

  def strike?
    @first_score == STRIKE_SCORE
  end

  private

  def score(mark)
    mark == STRIKE_MARK ? STRIKE_SCORE : mark.to_i
  end
end
