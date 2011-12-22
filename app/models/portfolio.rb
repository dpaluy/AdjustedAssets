class Portfolio
  include Mongoid::Document
  field :name
  field :number_of_stocks, :type => Integer, :default => 0
  field :cash_cents, :type => Integer, :default => 0
  field :currency, :default => Money.default_currency.to_s
  field :strategy_multiplier, :type => Integer, :default => 1  
  
#  validates :name, :presence => true, :uniqueness => true
#  validates :number_of_stocks, :presence => true
#  validates :cash_cents, :presence => true  
#  validates :strategy_multiplier, :presence => true  
  
  def cash
    Money.new self.cash_cents, self.currency
  end

  def cash=(new_value)
    new_value = new_value.cents if new_value.is_a? Money
    new_value = new_value.to_f * 100 if new_value.is_a? String
       
    self.cash_cents = new_value
  end
end

