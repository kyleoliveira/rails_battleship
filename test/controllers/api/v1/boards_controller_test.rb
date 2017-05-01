require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  def setup
    @controller = Api::V1::BoardsController.new
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
    assert_equal ActiveModelSerializers::SerializableResource.new( Board.last).to_json, @response.body
  end

  test 'should whine about bad input' do
    assert_no_difference('Board.count') do
      post :create,
           params: {}
    end
    assert_response :bad_request
    assert_equal 'Bad formatting, probably...', @response.body
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

  test 'should nuke board' do
    assert_no_difference('Board.count') do
      put :nuke,
          params: {
              board_id: @board.id
          }
    end
    assert_response :ok
    assert_equal ActiveModelSerializers::SerializableResource.new( @board).to_json, @response.body
  end
end
