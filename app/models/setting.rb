class Setting
  include Mongoid::Document
  field :name, :unique => true
  field :multiplier, :type => Integer
  field :stock_fee, :type => Float
  field :option_fee, :type => Float
  field :supplement_cost, :type => Integer
  field :asset_adjustment, :type => Integer
  field :points_to_rehedge, :type => Integer
end

