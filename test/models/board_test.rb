require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  def setup
    @board = boards(:easy)
  end

  test 'should parse battleship string' do
    input_str = '[[0,3],[4,8],[6,6]]'
    output_array = [
      { x: 0, y: 3 },
      { x: 4, y: 8 },
      { x: 6, y: 6 }
    ]
    assert_equal output_array, Board.parse_input(input_str)
  end

  test 'should print current battleships' do
    output_str = '[[0,3],[4,8],[6,6]]'
    assert_equal output_str, @board.to_input
  end

  test 'should be valid' do
    assert @board.valid?
  end

  test 'should have more than 2 battleships' do
    board = Board.new battleships_attributes: [
      { x: 0, y: 3 },
      { x: 4, y: 8 }
    ]
    assert_not board.valid?
  end

  test 'should have less than 4 battleships' do
    board = Board.new battleships_attributes: [
      { x: 0, y: 3 },
      { x: 4, y: 8 },
      { x: 6, y: 6 },
      { x: 7, y: 6 }
    ]

    assert_not board.valid?
  end
end
