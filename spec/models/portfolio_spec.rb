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
    
    it 'should calculate total value of all options' do
      (1..5).each { |i| @portfolio.option_actions.create!(:call_put => true, :quantity => i,
                                                   :price_cents => i*1000, :strike => ((i*10) + 100)) }
      strike = 140
      @portfolio.value(strike).should == [[0, -550], [10, -550], [20, -550], [30, -550], [40, -550], [50, -550], [60, -550], [70, -550], [80, -550], [90, -550], [100, -550], [110, -550], [120, 450], [130, 3450], [140, 9450], [150, 19450], [160, 34450], [170, 49450], [180, 64450], [190, 79450], [200, 94450], [210, 109450], [220, 124450], [230, 139450], [240, 154450], [250, 169450], [260, 184450], [270, 199450], [280, 214450], [290, 229450]]
      
    end
  end
  
  describe 'options expiration' do
    before(:each) do
      @portfolio = Portfolio.create!(@attr)
      @expiration = Date.today - 1.month
      @strike = 1000
      (1..5).each do |i|
        s = (i%2 == 0)? 10 : -10
        @portfolio.option_actions.create!(:call_put => false, :quantity => i,
                                          :exercise_date => @expiration,
                                          :price_cents => i*1000, 
                                          :strike => @strike + i*s)
      end
      @p_l = Money.new 0
      @portfolio.option_actions.each { |o| @p_l += o.total_exercise_value(@strike) }
    end
        
    it 'should expire all options before today' do
      @portfolio.option_actions.count.should eq(5)
      @portfolio.expire_options_by(Date.today, @strike)
      @portfolio.option_actions.count.should eq(0)
    end
    
    it 'should add money transactions after expiration' do
      @portfolio.money_transactions.count.should eq(0)
      @portfolio.expire_options_by(Date.today, @strike)
      @portfolio.money_transactions.count.should eq(1)
      transaction = @portfolio.money_transactions.first
      transaction.value.should == @p_l
      transaction.created_at.should == Date.today
    end
    
    it 'should verify cash after expiration' do
      @portfolio.expire_options_by(Date.today, @strike)
      @portfolio.cash.should == (@p_l + Money.new(100*@attr[:initial_investment]))
    end
    
    it 'should ignore not expired options' do
      option = @portfolio.option_actions.create!(:call_put => false, :quantity => 2,
                                          :exercise_date => Date.today + 1.day,
                                          :price_cents => 1000, 
                                          :strike => @strike + 10)
      @portfolio.expire_options_by(Date.today, @strike)
      @portfolio.option_actions.count.should eq(1)
      @portfolio.option_actions.first.should == option
    end
  end
end

