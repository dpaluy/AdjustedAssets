Given /^default portfolio exists with name "([^"]*)" and assets$/ do |name, table|
  step %{default portfolio exists with name "#{name}"}

  # Convert all headers to lower case symbol
  table.map_headers! {|header| header.downcase.gsub(' ','_') }
  portfolio = Portfolio.where(:name => name).first
  table.hashes.each do |attributes|
    portfolio.asset_actions.create!(attributes)
  end
end

