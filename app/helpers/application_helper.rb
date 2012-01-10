module ApplicationHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s)  }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end
  
  def pretty_money(money)
    number_to_currency(money.to_f, :unit => money.symbol, :separator => ".", :delimiter => ",", :precision => 2)
  end
  
end
