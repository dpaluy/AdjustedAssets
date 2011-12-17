class Setting
  include Mongoid::Document
  field :name, :type => String
  field :multiplier, :type => Integer
  field :stock_fee, :type => Integer
  field :option_fee, :type => Integer
  field :supplement_cost, :type => Integer
  field :asset_adjustment, :type => Integer
  field :points_to_rehedge, :type => Integer
end
