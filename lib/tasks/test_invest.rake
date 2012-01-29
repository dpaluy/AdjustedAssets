require 'config/environment'
require "#{Rails.root}/lib/invest/invest"
require "#{Rails.root}/lib/invest/data_loader"

desc "Test investment"
task :test_invest do
  asset_values = DataLoader.get_all_asset_values 
  strike = asset_values[0][0]
  portfolio = Portfolio.where(name: 'TA25').first
  settings = Setting.where(name: 'TA25').first
  Invest.build_initial_position(strike, portfolio, settings)
  
  stage = 0
  asset_values.each do |asset|
    asset_price = asset[0]
    today = asset[1]
    if (asset_price - strike).abs > settings.points_to_rehedge 
      if (asset_price > strike) # market up
        puts "UP #{asset_price} #{today}"
        Invest.up(portfolio, asset_price, stage, settings)
        stage -= 1 if stage > 0
      else  # market down
        puts "Down #{asset_price} #{today}"
        stage += 1
        supplement_quantity = stage * settings.supplement_stock
        Invest.down(portfolio, asset_price, strike, supplement_quantity)
      end
      strike = asset_price
    end
  end
end
