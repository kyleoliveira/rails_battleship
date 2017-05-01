class Board < ApplicationRecord
  has_many :battleships, inverse_of: :board

  validates :battleships, length: { is: 3 }

  accepts_nested_attributes_for :battleships

  MAX_GRID_LENGTH = 10
  MAX_GRID_WIDTH = 10

  def self.parse_input(input)
    found_pairs = input.scan(/(\d,\d)+/).flatten

    found_pairs&.collect do |b|
      x, y = b.scan(/(\d),(\d)/).first

      {
        x: x.to_i,
        y: y.to_i
      }
    end
  end

  def nuke!
    battleships.each(&:nuke!)
  end

  def to_input
    "[#{battleships.order(x: :asc).collect(&:to_input).join(',').gsub(/,$/, '')}]"
  end

  def status_indicator
    battleships.order(x: :asc).collect(&:status_indicator).to_s
  end

  def register_hit(x, y)
    battleships.each do |battleship|
      return battleship.hit!(x, y) if battleship.would_be_hit?(x, y)
    end

    HitResponse::MISS
  end

  def game_over?
    battleships.all?(&:sunk?)
  end
end
