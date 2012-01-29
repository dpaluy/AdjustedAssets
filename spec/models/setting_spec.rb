require 'spec_helper'

describe Setting do

  before(:each) do
    @attr = { 
      :name => 'TestSettings',
      :multiplier => 100,
      :stock_fee => 0.8,
      :option_fee => 2.2,
      :supplement_stock => 1,
      :asset_adjustment => 30, #%
      :points_to_rehedge => 50
    }
  end
    
  it "should create a new instance given a valid attribute" do
    Setting.create!(@attr)
  end
  
  def required_param_missing(param)
    no_param_set = Setting.new(@attr.merge(param => ""))
    no_param_set.should_not be_valid
  end
  
  it "should require all parameters" do
    required_param_missing('name')
    required_param_missing('multiplier')
    required_param_missing('stock_fee')
    required_param_missing('option_fee')
    required_param_missing('supplement_stock')
    required_param_missing('asset_adjustment')
    required_param_missing('points_to_rehedge')
  end
  
  it "should reject duplicate name" do
     Setting.create!(@attr)
     setting_with_duplicate_name = Setting.create(@attr)
     setting_with_duplicate_name.should_not be_valid
  end
  
end
