class BoardSerializer < ActiveModel::Serializer
  attribute :id
  has_many :battleships, serializer: BattleshipSerializer
end
