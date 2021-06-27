# frozen_string_literal: true

class Game
  def initialize(input_text)
    @frames = Frame.build_frames(input_text)
  end

  def calculate_score
    [base_score, bonus_score].sum
  end

  private

  def base_score
    @frames.map(&:base_score).sum
  end

  def bonus_score
    @frames.map(&:bonus_score).sum
  end
end

class Frame
  STRIKE = 10

  attr_writer :bonus_shot_candidates

  def initialize(first_shot, second_shot = nil)
    @first_shot = first_shot
    @second_shot = second_shot
    @bonus_shot_candidates = []
  end

  def strike?
    @first_shot.score == STRIKE
  end

  def spare?
    @first_shot.score != STRIKE && [@first_shot.score, @second_shot.score].sum == 10
  end

  def base_score
    strike? || spare? ? STRIKE : @first_shot.score + @second_shot.score
  end

  def bonus_score
    if strike?
      @bonus_shot_candidates.map(&:score).sum
    elsif spare?
      @bonus_shot_candidates[0].score
    else
      0
    end
  end

  class << self
    def build_frames(pinfall_text)
      shots = Shot.build_shots(pinfall_text)

      Array.new(10).map do
        first_shot = shots.shift
        frame = Frame.new(first_shot)
        frame = Frame.new(first_shot, shots.shift) unless frame.strike?
        frame.bonus_shot_candidates = shots[0, 2]
        frame
      end
    end
  end
end

class Shot
  def initialize(pinfall)
    @pinfall = pinfall
  end

  def score
    @pinfall == 'X' ? 10 : @pinfall.to_i
  end

  class << self
    def build_shots(pinfall_text)
      pinfall_text.split(',').map { |pinfall| Shot.new(pinfall) }
    end
  end
end

puts Game.new(ARGV[0]).calculate_score if __FILE__ == $PROGRAM_NAME
