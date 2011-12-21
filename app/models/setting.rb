class Setting
  include Mongoid::Document
  field :name, :unique => true
  field :multiplier, :type => Integer
  field :stock_fee, :type => Float
  field :option_fee, :type => Float
  field :supplement_cost, :type => Integer
  field :asset_adjustment, :type => Integer
  field :points_to_rehedge, :type => Integer
  
  validates :name, :presence => true, :uniqueness => true
  validates :multiplier, :presence => true
  validates :stock_fee, :presence => true
  validates :option_fee, :presence => true  
  validates :supplement_cost, :presence => true  
  validates :asset_adjustment, :presence => true  
  validates :points_to_rehedge, :presence => true      
end

