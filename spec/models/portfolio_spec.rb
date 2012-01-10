require 'spec_helper'

describe Portfolio do

  before(:each) do
    @attr = {
      :name => "MyPortfolio",
      :initial_investment => 150000,
      :currency => "ILS",
    }
  end

  def required_param_missing(param)
    no_param_set = Portfolio.new(@attr.merge(param => ""))
    no_param_set.should_not be_valid
  end

  it "should create a new instance given a valid attribute" do
    Portfolio.create!(@attr)
  end
  
  it "should require all parameters" do
    required_param_missing('name')
    required_param_missing('initial_investment')
  end

  it "should reject duplicate name" do
    Portfolio.create!(@attr)
    portfolio_with_duplicate_name = Portfolio.create(@attr)
    portfolio_with_duplicate_name.should_not be_valid
  end

  describe 'should convert cash to Money' do
    before(:each) do
      @portfolio = Portfolio.create!(@attr)
    end

    it "returns cash as Money"  do
      money = Money.new(@attr[:initial_investment] * 100, @attr[:currency])
      @portfolio.cash.should eql(money)
    end
  end
  
  describe 'summarize portfolio params' do
    before(:each) do
      @portfolio = Portfolio.create!(@attr)
      @cents = 100
    end

    it 'should summarize all assets' do
      (1..5).each { |i| @portfolio.asset_actions.create!(:quantity => i, :price_cents =>  100 + (i*10) ) }    
      @portfolio.number_of_stocks.should == 15
    end
    
    it 'should summarize all options' do
      (1..5).each { |i| @portfolio.option_actions.create!(:call_put => true, :quantity => i,
                                                         :price_cents => i*1000, :strike => @cents * ((i*10) + 100)) }
      (1..5).each { |i| @portfolio.option_actions.create!(:call_put => false, :quantity => -i,
                                                         :price_cents => i*1000, :strike => @cents * ((i*10) + 100 )) }
    
      @portfolio.number_of_call_options.should == 15
      @portfolio.number_of_put_options.should == -15
    end  
    
    it 'should calculate total value of all assets in given range' do
      (1..3).each { |i| @portfolio.asset_actions.create!(:quantity => i, :price_cents =>  @cents * (100+(i*10))) }
      (3..1).each { |i| @portfolio.asset_actions.create!(:quantity =>-i, :price_cents => @cents * (110-(i*10))) }      
      range = 50..150
      @portfolio.value(range).should == [[50, -440.0],
                                         [60, -380.0],
                                         [70, -320.0],
                                         [80, -260.0],
                                         [90, -200.0],
                                         [100, -140.0],
                                         [110, -80.0],
                                         [120, -20.0],
                                         [130, 40.0],
                                         [140, 100.0],
                                         [150, 160.0]]

    end
  end
  
end

