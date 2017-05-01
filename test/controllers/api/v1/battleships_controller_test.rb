require 'test_helper'

class BattleshipsControllerTest < ActionController::TestCase
  def setup
    @controller = Api::V1::BattleshipsController.new
    @board = boards(:almost_done)
  end

  test 'should create battleships' do
    assert_difference('Board.count', 1) do
      post :create,
           params: {
             positions: '[[0,3], [4,8], [6,6]]'
           }
    end
    assert_response :ok
    assert_equal 'OK', @response.body
  end

  test 'should require more than 2 battleships' do
    assert_no_difference('Battleship.count') do
      post :create,
           params: {
             positions: '[[0,3], [6,6]]'
           }
    end
    assert_response :length_required
    assert_equal 'Need more ships', @response.body
  end

  test 'should require less than 4 battleships' do
    assert_no_difference('Battleship.count') do
      post :create,
           params: {
             positions: '[[0,3], [4,8], [6,6], [7,6]]'
           }
    end
    assert_response :not_acceptable, 'Need fewer ships'
  end

  test 'should reference Monty Python when 5 battleships' do
    assert_no_difference('Battleship.count') do
      post :create,
           params: {
             positions: '[[0,3], [4,8], [6,6], [7,6], [8,6]]'
           }
    end
    assert_response :not_acceptable
    assert_equal 'Five is right out!', @response.body
  end

  test 'should hit battleships' do
    put :update,
        params: { id: @board.id, x: 0, y: 1 }
    assert_response :ok
    assert_equal 'hit', @response.body
  end

  test 'should miss battleships' do
    put :update,
        params: { id: @board.id, x: 0, y: 0 }
    assert_response :ok
    assert_equal 'miss', @response.body
  end

  test 'should sink battleships' do
    put :update,
        params: { id: @board.id, x: 6, y: 6 }
    assert_response :ok
    assert_equal 'sunk', @response.body
  end

  test 'should report game over' do
    put :update,
        params: { id: @board.id, x: 6, y: 6 }
    put :update,
        params: { id: @board.id, x: 0, y: 1 }
    put :update,
        params: { id: @board.id, x: 0, y: 2 }

    assert_response :ok
    assert_equal 'game over!', @response.body
  end
end
