module ApplicationHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s)  }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end
  
  def pretty_money(money, precision = 2)
    unless money.nil?
      number_to_currency(money.to_f, :unit => money.symbol, :delimiter => ",", 
              :separator => ".", :precision => precision)
    end
  end
  
end
