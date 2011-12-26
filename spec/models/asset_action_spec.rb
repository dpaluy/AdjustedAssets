require 'spec_helper'

describe AssetAction do

  before(:each) do
    @portfolio = Factory(:portfolio)
    @attr = {
      :quantity => 100,
      :price_cents => 15000000,
    }
  end

  it "should create a new instance given a valid attribute" do
    @portfolio.asset_actions.create!(@attr)
  end

  describe 'invalid parameters' do
    it 'should not create a new instance with zero quantity' do
      invalid_asset = @portfolio.asset_actions.create(@attr.merge(:quantity => 0))
      invalid_asset.should_not be_valid
    end
    
    it 'should not create a new instance with price less or equal 0' do
      invalid_asset = @portfolio.asset_actions.create(@attr.merge(:price_cents => 0))
      invalid_asset.should_not be_valid
      
      invalid_asset = @portfolio.asset_actions.create(@attr.merge(:price_cents => -1))
      invalid_asset.should_not be_valid
    end
  end
  
  describe 'should convert price to/from Money' do
    before(:each) do
      @asset = @portfolio.asset_actions.create!(@attr)
    end

    it "returns price as Money"  do
     @asset.price.should eql(Money.new(@attr[:price_cents]))
    end

    def update_price(price)
      @asset.price = price
      @asset.save!
      @asset.price_cents.should == (price.to_f * 100)
    end

    it 'updates price from string' do
      price = "19.90"
      update_price(price)
    end

    it 'updates price from number' do
      price = 19.90
      update_price(price)

      # Fixnum
      price = 1178
      update_price(price)
    end
  end

  describe 'total cost' do  
    it "should return total cost of stocks" do
      @asset = @portfolio.asset_actions.create!(@attr)
      @asset.total_cost.should == (@attr[:price_cents] * @attr[:quantity] / 100)  
    end
    
    it 'should return total value on strike - [Long, Decline]' do
      @asset = @portfolio.asset_actions.create!(@attr)
      strike = @attr[:price_cents] / 100 - 25
      @asset.value_on_strike(strike).should == (strike - (@attr[:price_cents] / 100) ) * @attr[:quantity]
    end

    it 'should return total value on strike - [Short, Decline]' do
      new_quantity = -250
      @asset = @portfolio.asset_actions.create!(@attr.merge(:quantity => new_quantity))
      strike = @attr[:price_cents] / 100 - 25
      @asset.value_on_strike(strike).should == (strike - (@attr[:price_cents] / 100) ) * new_quantity
    end
    
    it 'should return total value on strike - [Short, Grow]'   do
      new_quantity = -250
      @asset = @portfolio.asset_actions.create!(@attr.merge(:quantity => new_quantity))
      strike = @attr[:price_cents] / 100 + 40
      @asset.value_on_strike(strike).should == (strike - (@attr[:price_cents] / 100) ) * new_quantity
    end
  end
end

