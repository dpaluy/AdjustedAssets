require "net/http"

module DataLoader
  @hostURL = "stockcollector.herokuapp.com"
  @values = "/assets/1091826/values.json"
  @volatility = "/volatilities/4f1fee0e9708990003000026/vol_values.json"
  @http = Net::HTTP.new(@hostURL)
  @options = "/assets/1091826/options"
  
  def self.get_all_asset_values
    request = Net::HTTP::Get.new(@values)
    request.content_type = 'application/json'
    response = @http.request(request)
    result = JSON.parse(response.body)
    list = result.map do |r| 
      [r["price"]/100, Date.parse(r["timestamp"])]
    end
    list
  end
  
  def self.get_all_volatility_values
    request = Net::HTTP::Get.new(@volatilities)
    request.content_type = 'application/json'
    response = @http.request(request)
    result = JSON.parse(response.body)
    list = result.map do |r| 
      [r["value"]/100, Date.parse(r["timestamp"])]
    end
    list    
  end
  
  def get_options(exp)
    
  end
end
