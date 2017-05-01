module Api::V1
  class BoardsController < ApiController
    include ActionController::Serialization

    before_action :set_board, only: [:nuke]

    def index
      games = Board.all.collect { |b| { id: b.id, status: b.status_indicator } }
      render plain: games.to_s, status: :ok
    end

    def create
      positions = Board.parse_input(params['positions'])

      @board = Board.new battleships_attributes: positions unless positions.nil?

      if !@board.nil? && @board.save
        render plain: 'OK', status: :ok
      else
        render ShipCountErrorMessageService.new(positions: positions).perform
      end
    end

    def show
      render plain: 'Not implemented', status: :bad_request
    end

    def update
      render plain: 'Not implemented', status: :bad_request
    end

    def destroy
      render plain: 'Not implemented', status: :bad_request
    end

    def nuke
      @board.nuke!
      render plain: @board.status_indicator, status: :ok
    end

    private

      def set_board
        @board = Board.find(params[:id])
      end
  end
end
