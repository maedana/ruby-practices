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

  attr_writer :bonus_shots

  def initialize(first_shot, second_shot = nil)
    @first_shot = first_shot
    @second_shot = second_shot
    @bonus_shots = []
  end

  def strike?
    @first_shot.score == STRIKE
  end

  def spare?
    @first_shot.score != STRIKE && [@first_shot.score, @second_shot.score].sum == 10
  end

  def base_score
    strike? || spare? ? STRIKE : (@first_shot.score + @second_shot&.score || 0)
  end

  def bonus_score
    if strike?
      @bonus_shots.map(&:score).sum
    elsif spare?
      @bonus_shots[0].score
    else
      0
    end
  end

  class << self
    def build_frames(pinfall_text)
      shots = Shot.build_shots(pinfall_text)

      10.times.map do |index|
        first_shot = shots.shift
        frame = Frame.new(first_shot)
        frame = Frame.new(first_shot, shots.shift) unless frame.strike?
        frame.bonus_shots = shots[0, 2]
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
