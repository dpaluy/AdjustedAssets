class AssetAction
  include Mongoid::Document
  field :quantity, :type => Integer, :default => 0
  field :price_cents, :type => Integer, :default => 0
  field :currency, :default => Money.default_currency.to_s
  embedded_in :portfolio, :inverse_of => :asset_actions

  validate :quantity_not_zero
  validate :price_positive
 
  def price
    Money.new self.price_cents, self.currency
  end

  def price=(new_value)
    new_value = new_value.cents if new_value.is_a? Money
    new_value = new_value.to_f * 100 if [String, Fixnum, Float].include? new_value.class
    self.price_cents = new_value
  end

  def total_cost
    Money.new self.quantity * self.price_cents, self.currency
  end

  def value_on_strike(strike)
    (strike - price.to_f) * quantity
  end
  
  private

  def quantity_not_zero
    errors.add(:quantity, "can't be zero!") if (quantity == 0)
  end

  def price_positive
    errors.add(:price, "must be positive!") if (price_cents <= 0)
  end
end

