class BattleshipSerializer < ActiveModel::Serializer
  attributes :x, :y, :status

  def status
    object.horizontal_status_indicator
  end
end
