require 'spec_helper'

describe Portfolio do

  before(:each) do
    @attr = {
      :name => "MyPortfolio",
      :cash_cents => 15000000,
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
    required_param_missing('cash_cents')
  end

  it "should reject duplicate name" do
    Portfolio.create!(@attr)
    portfolio_with_duplicate_name = Portfolio.create(@attr)
    portfolio_with_duplicate_name.should_not be_valid
  end

  describe 'should convert cash to/from Money' do
    before(:each) do
      @portfolio = Portfolio.create!(@attr)
    end

    it "returns cash as Money"  do
      @portfolio.cash.should eql(Money.new(@attr[:cash_cents], @attr[:currency]))
    end

    def update_cash(cash)
      @portfolio.cash = cash
      @portfolio.save!
      @portfolio.cash_cents.should == (cash.to_f * 100)
    end

    it 'updates cash from string' do
      cash = "19.90"
      update_cash(cash)
    end

    it 'updates cash from number' do
      cash = 19.90
      update_cash(cash)

      # Fixnum
      cash = 1178
      update_cash(cash)
    end
  end
  
  describe 'summarize portfolio params' do
    before(:each) do
      @portfolio = Portfolio.create!(@attr)
      (1..5).each { |i| @portfolio.asset_actions.create!(:quantity => i, :price_cents => i*1000 ) }
      (1..5).each { |i| @portfolio.option_actions.create!(:call_put => true, :quantity => i,
                                                         :price_cents => i*1000, :strike => i * 100 ) }
      (1..5).each { |i| @portfolio.option_actions.create!(:call_put => false, :quantity => -i,
                                                         :price_cents => i*1000, :strike => i * 100 ) }
    end

    it 'should summarize all assets' do
      @portfolio.number_of_stocks.should == 15
    end
    
    it 'should summarize all options' do
      @portfolio.number_of_call_options.should == 15
      @portfolio.number_of_put_options.should == -15
    end  
  end
  
end

