class OptionAction
  include Mongoid::Document
  field :call_put, :type => Boolean, :default => true
  field :strike, :type => Integer
  field :quantity, :type => Integer
  field :price_cents, :type => Integer, :default => 0
  field :currency, :default => Money.default_currency.to_s
  field :expiration_date, :type => Date, :default => (Time.now + 1.month)
  embedded_in :portfolio, :inverse_of => :option_actions

  validate :quantity_not_zero
  validate :price_positive
  validate :expiration_date, :presence => true, :date => { :after => Time.now - 1.year, :before => Time.now + 4.month }
  
  def expiration_value(current_strike)
    value = (current_strike - strike) * 100
    if !is_call?
      value *= -1 # PUT
    end
    value = 0 if (value <= 0)
    value * quantity
  end
   
  def is_expired?(today)
    (today >= expiration_date)  
  end
  
  def is_call?
    call_put == true  
  end
  
  def price
    Money.new self.price_cents, self.currency
  end

  def price=(new_value)
    new_value = new_value.cents if new_value.is_a? Money
    new_value = new_value.to_f * 100 if [String, Fixnum, Float].include? new_value.class
    self.price_cents = new_value
  end

  def total_cost
    quantity * price.to_f
  end

  private

  def quantity_not_zero
    errors.add(:quantity, "can't be zero!") if (quantity == 0)
  end

  def price_positive
    errors.add(:price, "must be positive!") if (price_cents <= 0)
  end
end
