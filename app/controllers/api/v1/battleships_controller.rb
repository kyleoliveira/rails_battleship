module Api::V1
  class BattleshipsController < ApplicationController
    include ActionController::Serialization

    def create
      # positions = Board.parse_input(params['positions'])
      positions = params[:positions].collect { |r| { x: r[:x].to_i, y: r[:y].to_i } }

      @board = Board.new battleships_attributes: positions
      if @board.save
        render plain: 'OK', status: :ok
      else
        render ShipCountErrorMessageService.new(positions: positions).perform
      end
    end

    def update
      @board = Board.first
      x = params['x'].to_i
      y = params['y'].to_i

      # Fill in body to take x and y coordinates and return result as "miss", "hit" or "sunk"
      result = @board.register_hit(x, y)
      render plain: result
    end
  end
end
