require 'test_helper'

class BattleshipTest < ActiveSupport::TestCase
  def setup
    @battleship = Battleship.new x: 0, y: 2
    # @max_grid_length = 10
    # @max_grid_width = 10
  end

  test 'should be valid' do
    assert @battleship.valid?
  end

  test 'x should be present' do
    @battleship.x = nil
    assert_not @battleship.valid?
  end

  test 'x should be positive integer' do
    @battleship.x = -1
    assert_not @battleship.valid?
  end

  test 'x should be in bounds' do
    @battleship.x = Board.MAX_GRID_WIDTH + 1
    assert_not @battleship.valid?
  end

  test 'y should be present' do
    @battleship.y = nil
    assert_not @battleship.valid?
  end

  test 'y should be positive integer' do
    @battleship.y = -1
    assert_not @battleship.valid?
  end

  test 'y should be in bounds' do
    @battleship.y = Board.MAX_GRID_LENGTH + 1
    assert_not @battleship.valid?
  end

  test 'should start out unhit' do
    assert_not @battleship.bow_hit?
    assert_not @battleship.middle_hit?
    assert_not @battleship.aft_hit?
  end
end
