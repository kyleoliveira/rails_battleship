class Board < ApplicationRecord
  has_many :battleships, inverse_of: :board

  validates :battleships, length: { is: 3 }

  accepts_nested_attributes_for :battleships

  MAX_GRID_LENGTH = 10
  MAX_GRID_WIDTH = 10

  def self.parse_input(input)
    found = input.scan(/\[\[(.,.)\],\[(.,.)\],\[(.,.)\]\]/)
    found.collect { |b| { x: b[0], y: b[1] } }
  end

  def to_input
    "[#{battleships.collect(&:to_input).join(',').gsub(/,$/, '')}]"
  end

  def register_hit(x, y)
    battleships.each do |battleship|
      return battleship.hit!(x, y) if battleship.would_be_hit?(x, y)
    end
  end
end
