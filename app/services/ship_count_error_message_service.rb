class ShipCountErrorMessageService
  def initialize(params)
    @positions = params[:positions]
  end

  def perform
    case
      when @positions.length < 3
        return { plain: 'Need more ships', status: :length_required }
      when @positions.length > 3
        return { plain: 'Need fewer ships', status: :not_acceptable }
      when @positions.length == 5
        return { plain: 'Five is right out!', status: :not_acceptable }
      else
        return { plain: 'Bad formatting, probably...', status: :bad_request }
    end
  end

end