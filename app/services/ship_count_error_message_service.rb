class ShipCountErrorMessageService
  def initialize(params)
    @positions = params[:positions]
  end

  def perform
    if @positions.nil?
      { plain: 'Bad formatting, probably...', status: :bad_request }
    elsif @positions.length == 5
      { plain: 'Five is right out!', status: :not_acceptable }
    elsif @positions.length < 3
      { plain: 'Need more ships', status: :length_required }
    elsif @positions.length > 3
      { plain: 'Need fewer ships', status: :not_acceptable }
    end
  end
end
