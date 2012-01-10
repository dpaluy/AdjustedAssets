class Portfolio
  include Mongoid::Document
  field :name
  field :cash_cents, :type => Integer, :default => 0
  field :currency, :default => Money.default_currency.to_s
  field :created_at, :type => Date, :default => Time.now
  embeds_many :asset_actions
  embeds_many :option_actions
  key :name

  validates :name, :presence => true, :uniqueness => true
  validates :cash_cents, :presence => true

  def cash
    Money.new self.cash_cents, self.currency
  end

  def cash=(new_value)
    new_value = new_value.cents if new_value.is_a? Money
    new_value = new_value.to_f * 100 if [String, Fixnum, Float].include? new_value.class

    self.cash_cents = new_value
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

