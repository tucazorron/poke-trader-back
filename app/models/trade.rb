class Trade
  include Mongoid::Document
  field :player1, type: String
  field :player2, type: String
  field :baseexp1, type: Integer
  field :baseexp2, type: Integer
  field :fair, type: Mongoid::Boolean
end
