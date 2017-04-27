require 'test_helper'

class BattleshipsControllerTest < ActionController::TestCase
  def setup
    # @easy_ships = battleships(:ships)
    @controller = Api::V1::BattleshipsController.new
    @board = Board.new battleships_attributes: [
        {x: 0, y: 3},
        {x: 4, y: 8},
        {x: 6, y: 6}
    ]
    @board.save
  end

  test 'should create battleships' do
    assert_difference('Battleship.count', 3) do
      post :create,
           params: {
             positions: [
                 {x: 0, y: 3},
                 {x: 4, y: 8},
                 {x: 6, y: 6}
             ]
           }
    end
    assert_response :ok, 'OK'
  end

  test 'should require more than 2 battleships' do
    assert_no_difference('Battleship.count') do
      post :create,
           params: {
               positions: [
                   {x: 0, y: 3},
                   {x: 6, y: 6}
               ]
           }
    end
    assert_response :length_required, 'Need more ships'
  end

  test 'should require less than 4 battleships' do
    assert_no_difference('Battleship.count') do
      post :create,
           params: {
               positions: [
                   {x: 0, y: 3},
                   {x: 4, y: 8},
                   {x: 6, y: 6},
                   {x: 7, y: 6}
               ]
           }
    end
    assert_response :not_acceptable, 'Need fewer ships'
  end

  test 'should reference Monty Python when 5 battleships' do
    assert_no_difference('Battleship.count') do
      post :create,
           params: {
               positions: [
                   {x: 0, y: 3},
                   {x: 4, y: 8},
                   {x: 6, y: 6},
                   {x: 7, y: 6},
                   {x: 8, y: 6}
               ]
           }
    end
    assert_response :not_acceptable, 'Five is right out!'
  end

  test 'should hit battleships' do
    # TODO: Needs a fixture with a proper board
    patch :update,
          params: { x: 0, y: 0 }
    assert_response :ok, 'hit'
  end

  test 'should miss battleships' do
    # TODO: Needs a fixture with a proper board
    patch :update,
          params: { x: 0, y: 0 }
    assert_response :ok, 'miss'
  end

  test 'should sunk battleships' do
    # TODO: Needs a fixture with a proper board
    patch :update,
          params: { x: 0, y: 0 }
    assert_response :ok, 'sunk'
  end

  test 'should report game over' do
    # TODO: Needs a fixture with a nearly won board
    patch :update,
          params: { x: 0, y: 0 }
    assert_response :ok, 'game over!'
  end
end