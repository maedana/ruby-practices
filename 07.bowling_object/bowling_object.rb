# frozen_string_literal: true

class Game
  attr_reader :input_text

  def initialize(input_text)
    @frames = build_frames(input_text)
  end

  def calculate_score
    [base_score, bonus_score].sum
  end

  private

  def base_score
    @frames.map(&:base_score).sum
  end

  def bonus_score
    shots = @frames.map(&:shots).flatten
    shot_count = 0
    @frames.each.sum do |frame|
      if frame.strike?
        shot_count += 1
        shots[shot_count, 2].map(&:score).sum
      elsif frame.spare?
        shot_count += 2
        shots[shot_count].score
      else
        shot_count += 2
        0
      end
    end
  end

  def build_frames(pinfall_text)
    shots = Shot.build_shots(pinfall_text)

    10.times.map do |index|
      if index == 9
        Frame.new(*shots)
      else
        first_shot = shots.shift
        frame = Frame.new(first_shot)
        frame.strike? ? frame : Frame.new(first_shot, shots.shift)
      end
    end
  end
end

class Frame
  STRIKE = 10
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_shot, second_shot = nil, third_shot = nil)
    @first_shot = first_shot
    @second_shot = second_shot
    @third_shot = third_shot
  end

  def strike?
    @first_shot.score == STRIKE
  end

  def spare?
    @first_shot.score != STRIKE && [@first_shot.score, @second_shot.score].sum == 10
  end

  def shots
    [@first_shot, @second_shot, @third_shot].compact
  end

  def base_score
    (self.strike? || self.spare?) ? STRIKE : shots.map(&:score).sum
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


if __FILE__ == $PROGRAM_NAME
  puts Game.new(ARGV[0]).calculate_score
end
