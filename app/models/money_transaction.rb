class MoneyTransaction
  include Mongoid::Document
  field :value_cents, :type => Integer, :default => 0
  field :currency, :default => Money.default_currency.to_s
  field :created_at, :type => Date, :default => Time.now
  field :note
  embedded_in :portfolio, :inverse_of => :money_transactions
  
  validate :value_not_zero
  
  def value
    Money.new self.value_cents, self.currency
  end

  def value=(new_value)
    if new_value.is_a? Money
      new_value = new_value.cents 
    else
      new_value = new_value.to_f * 100 if [String, Fixnum, Float].include? new_value.class
    end
    self.value_cents = new_value
  end
  
  private
  
  def value_not_zero
    errors.add(:value, "can't be zero!") if (value_cents == 0)
  end
end
