require 'spec_helper'

describe Portfolio do

  before(:each) do
    @attr = {
      :name => "MyPortfolio",
      :number_of_stocks => 100,
      :cash_cents => 15000000,
      :currency => "ILS",
      :strategy_multiplier => 1,
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
    required_param_missing('number_of_stocks')
    required_param_missing('cash_cents')
    required_param_missing('strategy_multiplier')
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
end

