require 'test_helper'

class BattleshipsControllerTest < ActionController::TestCase
  def setup
    @controller = Api::V1::BattleshipsController.new
    @board = boards(:almost_done)
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
