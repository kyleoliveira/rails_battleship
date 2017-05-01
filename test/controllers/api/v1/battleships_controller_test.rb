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
    assert_equal HitResponse::HIT, @response.body
  end

  test 'should miss battleships' do
    put :update,
        params: { id: @board.id, x: 0, y: 0 }
    assert_response :ok
    assert_equal HitResponse::MISS, @response.body
  end

  test 'should sink battleships' do
    put :update,
        params: { id: @board.id, x: 6, y: 6 }
    assert_response :ok
    assert_equal HitResponse::SUNK, @response.body
  end

  test 'should report game over' do
    put :update,
        params: { id: @board.id, x: 6, y: 6 }
    put :update,
        params: { id: @board.id, x: 0, y: 1 }
    put :update,
        params: { id: @board.id, x: 0, y: 2 }

    assert_response :ok
    assert_equal HitResponse::GAME_OVER, @response.body
  end

  test 'should fail when not implemented (index)' do
    get :index
    assert_response :bad_request
    assert_equal not_implemented_message, @response.body
  end

  test 'should fail when not implemented (show)' do
    get :show,
        params: { id: @board.id }
    assert_response :bad_request
    assert_equal not_implemented_message, @response.body
  end

  test 'should fail when not implemented (create)' do
    post :create
    assert_response :bad_request
    assert_equal not_implemented_message, @response.body
  end

  test 'should fail when not implemented (destroy)' do
    post :destroy,
         params: { id: @board.id }
    assert_response :bad_request
    assert_equal not_implemented_message, @response.body
  end

  private

  def not_implemented_message
    {'Implemented': 'Nope'}.to_json
  end
end
