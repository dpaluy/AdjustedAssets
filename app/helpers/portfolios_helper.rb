module PortfoliosHelper

  def preaty_money(money)
    number_to_currency(money.to_f, :unit => money.symbol, :separator => ".", :delimiter => ",", :precision => 2)
  end
end
