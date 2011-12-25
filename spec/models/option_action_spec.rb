require 'spec_helper'

describe OptionAction do
  
  before(:each) do
    @portfolio = Factory(:portfolio)
    @attr = {
      :call_put => true,
      :strike => 1100,
      :quantity => -1,
      :price_cents => 10000,
      :expiration_date => Time.now
    }
  end
  
  describe 'valid attributes' do
    # "should create a new instance given a valid attribute"
    before do
      @option = @portfolio.option_actions.create!(@attr)
    end

    it 'should return CALL type on default attribute' do
      @option.is_call?.should eql(true)
    end
    
    it 'should create a new instance with negative quantity' do
      @portfolio.option_actions.create!(@attr.merge(:quantity => -1))
    end
  end

  describe 'invalid attributes' do
    it 'should not create a new instance with zero quantity' do
      invalid_option = @portfolio.option_actions.create(@attr.merge(:quantity => 0))
      invalid_option.should_not be_valid
    end
    
    it 'should not create a new instance with price less or equal 0' do
      invalid_option = @portfolio.option_actions.create(@attr.merge(:price_cents => 0))
      invalid_option.should_not be_valid
      
      invalid_option = @portfolio.option_actions.create(@attr.merge(:price_cents => -1))
      invalid_option.should_not be_valid
    end    
  end  
  
  describe 'should convert price to/from Money' do
    before(:each) do
      @option = @portfolio.option_actions.create!(@attr)
    end

    it "returns price as Money"  do
      @option.price.should eql(Money.new(@attr[:price_cents]))
    end

    def update_price(price)
      @option.price = price
      @option.save!
      @option.price_cents.should == (price.to_f * 100)
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
      @option = @portfolio.option_actions.create!(@attr)
    end
    
    it "should return total cost of stocks" do
      @option.total_cost.should == (@attr[:price_cents] * @attr[:quantity] / 100)  
    end
  end
  
end
