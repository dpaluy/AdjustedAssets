require 'spec_helper'

describe MoneyTransaction do
  before(:each) do
    @portfolio = Factory(:portfolio)
    @attr = {
      :value_cents => 100000,
      :note => 'Option Expiration'
    }
  end
  
  it "should create a new instance given a valid attribute" do
    @portfolio.money_transactions.create!(@attr)
  end
  
  describe 'invalid parameters' do    
    it 'should not create a new instance with price less or equal 0' do
      invalid_asset = @portfolio.asset_actions.create(@attr.merge(:value_cents => 0))
      invalid_asset.should_not be_valid
    end
  end
  
  describe 'should convert price to/from Money' do
    before(:each) do
      @transaction = @portfolio.money_transactions.create!(@attr)
    end

    it "returns price as Money"  do
     @transaction.value.should eql(Money.new(@attr[:value_cents]))
    end

    def update_price(value)
      @transaction.value = value
      @transaction.save!
      @transaction.value_cents.should == (value.to_f * 100)
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
end
