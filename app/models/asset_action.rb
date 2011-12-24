class AssetAction
  include Mongoid::Document
  field :quantity, :type => Integer
  field :price_cents, :type => Integer, :default => 0
  field :currency, :default => Money.default_currency.to_s
  embedded_in :portfolio, :inverse_of => :assets_actions
  
  def price
    Money.new self.price_cents, self.currency
  end

  def price=(new_value)
    new_value = new_value.cents if new_value.is_a? Money
    new_value = new_value.to_f * 100 if [String, Fixnum, Float].include? new_value.class

    self.price_cents = new_value
  end
end
