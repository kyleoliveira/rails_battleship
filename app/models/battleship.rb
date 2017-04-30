class Battleship < ApplicationRecord
  belongs_to :board, inverse_of: :battleships

  validates :x, presence: true,
                numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: Board::MAX_GRID_WIDTH }
  validates :y, presence: true,
                numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than: Board::MAX_GRID_LENGTH }

  def bow
    y
  end

  def middle
    y - 1
  end

  def aft
    y - 2
  end

  def would_be_hit?(x, y)
    x == self.x && (y == bow || y == middle || y == aft)
  end

  def sunk?
    bow_hit? && middle_hit? && aft_hit?
  end

  def to_input
    "[#{x},#{y}]"
  end

  def status_indicator
    [
      bow_hit? ? 'X' : '^',
      middle_hit? ? 'X' : '#',
      aft_hit? ? 'X' : 'V'
    ]
  end

  def hit!(x, y)
    if x == self.x
      case y
      when bow
        self.bow_hit = true
      when middle
        self.middle_hit = true
      when aft
        self.aft_hit = true
      end

      save!

      sunk? ? 'sunk' : 'hit'
    else
      'miss'
    end
  end
end
