module Invest
   
  def self.get_initial_quantity(strike, initial_investment, asset_adjustment)
    (initial_investment * asset_adjustment / 100) / strike
  end
  
  def self.build_initial_position(strike, portfolio, settings)
    quantity = get_initial_quantity(strike, portfolio.initial_investment, settings.asset_adjustment)
    portfolio.asset_actions.create!(:quantity => quantity, :price => strike)    
  end
  
  def self.down(portfolio, asset_price, old_asset_price, supplement_quantity)
    quantity = portfolio.number_of_stocks*(old_asset_price - asset_price)/asset_price
    total_quantity = supplement_quantity + quantity
    portfolio.asset_actions.create!(:quantity => total_quantity, :price => asset_price)
    puts "Buy #{total_quantity} #{asset_price}"    
  end
  
  def self.up(portfolio, asset_price, stage, settings)
    quantity = if (stage > 0) 
                (-stage * settings.supplement_stock)
               else
                get_initial_quantity(strike, portfolio.initial_investment,
                             settings.asset_adjustment) - portfolio.number_of_stocks
               end
    portfolio.asset_actions.create!(:quantity => quantity, :price => asset_price)
    puts "Sell #{quantity} #{asset_price}"
  end

end
