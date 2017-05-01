module Api::V1
  class BoardsController < ApiController
    include ActionController::Serialization

    before_action :set_board, only: [:show, :destroy, :nuke]

    def index
      render json: Board.all, status: :ok
    end

    def create
      positions = Board.parse_input(params['positions'])

      @board = Board.new battleships_attributes: positions unless positions.nil?

      if !@board.nil? && @board.save
        render json: @board, status: :ok
      else
        render ShipCountErrorMessageService.new(positions: positions).perform
      end
    end

    def show
      render json: @board, status: :ok
    end

    def update
      render json: {'Implemented': 'Nope'}, status: :bad_request
    end

    def destroy
      id = @board.id
      @board.destroy
      render json: { board: id, status: 'Destroyed' }, status: :ok
    end

    def nuke
      @board.nuke!
      render json: @board, status: :ok
    end

    private

      def set_board
        @board = Board.find(params[:id])
      end
  end
end
