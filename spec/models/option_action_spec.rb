require 'spec_helper'

describe OptionAction do
  
  before(:each) do
    @portfolio = Factory(:portfolio)
    @attr = {
      :call_put => true,
      :strike => 1100,
      :quantity => 2,
      :price_cents => 10000,
      :exercise_date => Date.today
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

  describe 'exercise of options - tools' do
    before(:each) do
      @option = @portfolio.option_actions.create!(@attr)
    end
    
    it 'should indicate if expired with given date' do
      today = @attr[:exercise_date]
      @option.is_expired?(today).should == true
      
      today = @attr[:exercise_date] + 1.day
      @option.is_expired?(today).should == true
      
      today = @attr[:exercise_date] - 1.day
      @option.is_expired?(today).should == false
    end
  end
  
  describe 'exercise of options - values' do
  
    def exercise_value(exercise_strike, strike, is_call)
      value = (exercise_strike - strike) * 100
      value *= -1 if !is_call
      value    
    end
    
    describe 'value on exercise - CALL' do
      before(:each) do
        @option = @portfolio.option_actions.create!(@attr)
      end

      it 'should return 0 if strike less or equal than option strike' do
        strike = @attr[:strike]
        @option.exercise_value(strike).should == 0
        
        strike = @attr[:strike] - 1
        @option.exercise_value(strike).should == 0
      end
    
      it 'should return exercise value while exercise strike is higher' do
        exercise_strike = @attr[:strike] + 10
        @option.exercise_value(exercise_strike).should == 
                    exercise_value(exercise_strike, @option.strike, @option.is_call?) * @option.quantity
      end
    end
    
    describe 'value on exercise - PUT' do
      before(:each) do
        @option = @portfolio.option_actions.create!(@attr.merge(:quantity => -3, :call_put => false))
      end
    
      it 'should return 0 if strike greater or equal than option strike' do
        strike = @attr[:strike]
        @option.exercise_value(strike).should == 0
        
        strike = @attr[:strike] + 1
        @option.exercise_value(strike).should == 0
      end
    
      it 'should return exercise value while exercise strike is less' do
        exercise_strike = @attr[:strike] - 10
        @option.exercise_value(exercise_strike).should == 
                    exercise_value(exercise_strike, @option.strike, @option.is_call?) * @option.quantity
      end
    end
    
  end
  
  describe 'invalid attributes' do
    def required_param_missing(param)
      no_param_set = @portfolio.option_actions.create(@attr.merge(param => ""))
      no_param_set.should_not be_valid
    end
  
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
    
    it 'should not create a new instance with missing required params' do
      required_param_missing('quantity')
      required_param_missing('price_cents')
      required_param_missing('exercise_date')
      required_param_missing('strike')
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
