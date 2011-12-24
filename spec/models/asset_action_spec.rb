require 'spec_helper'

describe AssetAction do

  before(:each) do
    @portfolio = Factory(:portfolio)
    @attr = {
      :quantity => 100,
      :price_cents => 15000000,
      :currency => "ILS",
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
    end
  end
  
  describe 'should convert price to/from Money' do
    before(:each) do
      @asset = @portfolio.asset_actions.create!(@attr)
    end

    it "returns price as Money"  do
     @asset.price.should eql(Money.new(@attr[:price_cents], @attr[:currency]))
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
    before(:each) do
      @asset = @portfolio.asset_actions.create!(@attr)
    end
    
    it "should return total cost of stocks" do
      @asset.total_cost.should == (@attr[:price_cents] * @attr[:quantity] / 100)  
    end
  end
end

