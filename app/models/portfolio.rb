class Portfolio
  include Mongoid::Document
  field :name
  field :initial_investment, :type => Integer
  field :currency, :default => Money.default_currency.to_s
  field :created_at, :type => Date, :default => Time.now
  embeds_many :asset_actions
  embeds_many :option_actions
  key :name

  validates :name, :presence => true, :uniqueness => true
  validates_numericality_of :initial_investment, :greater_than => 0
   
  def cash
    assets = asset_actions.inject(0) {|val, a| val - a.total_cost.cents}
    options = option_actions.inject(0) {|val, a| val - a.total_cost.cents}
    Money.new (100*self.initial_investment) + assets + options, self.currency 
  end

  def initial_money
    Money.new self.initial_investment*100, self.currency
  end
  
  def number_of_stocks
    asset_actions.sum(:quantity) || 0
  end
  
  def number_of_call_options
    number_of_options(true) || 0
  end
  
  def number_of_put_options
    number_of_options(false) || 0
  end
  
  def value(strike)
    step = 150
    if strike.class == Fixnum
      strike_range = (strike-step)..(strike+step) 
    else
      strike_range = strike
    end
    strike_range.step(10).map do |strike|
      assets = asset_actions.inject(0) {|val, a| val + a.value_on_strike(strike)}
      options = option_actions.inject(0) {|val, a| val + a.total_exercise_value(strike)}
      value = assets + options
      [strike, value] 
    end
  end
  
  def cost
    assets = asset_actions.inject(0) {|val, a| val + a.price}
    options = option_actions.inject(0) {|val, a| val + a.price}
    assets + options
  end
  
  private
  
  def number_of_options(call_put)
    option_actions.where(:call_put => call_put).sum(:quantity)
  end
end

