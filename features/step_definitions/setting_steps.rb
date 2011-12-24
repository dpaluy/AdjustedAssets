def default_attributes
  {
      :multiplier => "100",
      :name => "MyConfig",
      :stock_fee => "0.1",
      :option_fee => "2.2",
      :points_to_rehedge => "50",
      :supplement_cost => "1000",
      :asset_adjustment => "30" }

end

Given /^default settings exists$/ do
  attributes = default_attributes
  Setting.create!(attributes)
end

Given /^default setting exists with name "(.*)"$/ do |arg1|
  attributes = default_attributes.merge({:name => arg1})
  Setting.create!(attributes)
end

Given /^following settings exist$/ do |table|
  # Convert all headers to lower case symbol
  table.map_headers! {|header| header.downcase.gsub(' ','_') }

  table.hashes.each do |attributes|
    Setting.create!(attributes)
  end
end

