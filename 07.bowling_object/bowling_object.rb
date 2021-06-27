# frozen_string_literal: true

class Game
  attr_reader :input_text

  def initialize(input_text)
    build_frames(input_text)
  end

  def calculate_score
    [base_score, bonus_score].sum
  end

  private

  def base_score
    @shots_by_frames.flatten.map(&:score).sum
  end

  def bonus_score
    bonus = 0
    @frames.each_with_index do |shots, index|
      following_pinfalls = @shots_by_frames[index.succ..].flatten
      if shots.strike?
        bonus += following_pinfalls.map(&:score)[0..1].sum
      elsif index < 9 && shots.spare?
        bonus += following_pinfalls.map(&:score)[0]
      end
    end
    bonus
  end

  def build_frames(pinfall_text)
    @shots_by_frames = []
    frame = []
    Shot.build_shots(pinfall_text).map do |shot|
      frame << shot
      if frame.count == 2 || frame.count == 1 && shot.score == 10 || @shots_by_frames[9]
        @shots_by_frames << frame
        frame = []
      end
    end
    @shots_by_frames = [*@shots_by_frames[0..8], [*@shots_by_frames[9], *@shots_by_frames[10], *@shots_by_frames[11]]]
    @frames = @shots_by_frames.map { |shots| Frame.new(*shots) }
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
