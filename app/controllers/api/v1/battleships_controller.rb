module Api::V1
  class BattleshipsController < ApiController
    include ActionController::Serialization

    before_action :set_board, only: [:update]

    def index
      render plain: 'Not implemented', status: :bad_request
    end

    def show
      render plain: 'Not implemented', status: :bad_request
    end

    def create
      render plain: 'Not implemented', status: :bad_request
    end

    def destroy
      render plain: 'Not implemented', status: :bad_request
    end

    def update
      x = params[:x].to_i
      y = params[:y].to_i

      result = @board.register_hit(x, y)
      result = HitResponse::GAME_OVER if @board.game_over?

      render plain: result
    end

    private

      def set_board
        @board = Board.find(params[:id])
      end
  end
end
