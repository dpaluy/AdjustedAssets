require "net/http"

module DataLoader
  @hostURL = "stockcollector.herokuapp.com"
  @values = "/assets/1091826/values.json"
  @http = Net::HTTP.new(@hostURL)
  
  def DataLoader.get_all_asset_values
    request = Net::HTTP::Get.new(@values)
    request.content_type = 'application/json'
    response = @http.request(request)
    result = JSON.parse(response.body)
    list = result.map do |r| 
      [r["price"]/100, Date.parse(r["timestamp"])]
    end
    list
  end
end
