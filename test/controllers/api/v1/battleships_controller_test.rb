require 'test_helper'

class BattleshipsControllerTest < ActionController::TestCase
  def setup
    @controller = Api::V1::BattleshipsController.new
  end

  test 'should create battleships' do
    assert_difference('Battleship.count', 3) do
      post :create,
           params: {
             positions: [
               { x: 0, y: 3 },
               { x: 4, y: 8 },
               { x: 6, y: 6 }
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
               { x: 0, y: 3 },
               { x: 6, y: 6 }
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
               { x: 0, y: 3 },
               { x: 4, y: 8 },
               { x: 6, y: 6 },
               { x: 7, y: 6 }
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
               { x: 0, y: 3 },
               { x: 4, y: 8 },
               { x: 6, y: 6 },
               { x: 7, y: 6 },
               { x: 8, y: 6 }
             ]
           }
    end
    assert_response :not_acceptable, 'Five is right out!'
  end

  test 'should hit battleships' do
    include_board

    patch :update,
          params: { x: 0, y: 1 }
    assert_response :ok, 'hit'
  end

  test 'should miss battleships' do
    include_board

    patch :update,
          params: { x: 0, y: 0 }
    assert_response :ok, 'miss'
  end

  test 'should sunk battleships' do
    include_board

    patch :update,
          params: { x: 0, y: 0 }
    assert_response :ok, 'sunk'
  end

  test 'should report game over' do
    patch :update,
          params: { x: 0, y: 0 }
    assert_response :ok, 'game over!'
  end

  private

    def include_board
      board = boards(:easy)
      board.save!
    end
end
