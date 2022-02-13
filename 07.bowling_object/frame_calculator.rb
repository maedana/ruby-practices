# frozen_string_literal: true

class FrameCalculator
  def initialize(first_mark, second_mark, third_mark)
    @first_score = score(first_mark)
    @second_score = score(second_mark)
    @third_score = score(third_mark)
    @first_plus_second_score = @first_score + @second_score
  end

  def result
    return @first_plus_second_score if @first_plus_second_score < 10

    @first_plus_second_score + @third_score
  end

  private

  def score(mark)
    mark == 'X' ? 10 : mark.to_i
  end
end
