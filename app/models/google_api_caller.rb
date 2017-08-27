class GoogleAPICaller < ApplicationRecord

  def self.get_location_info(address)
    query_response=parse_api_response(query_google_api(address))
    coordinates=extract_coordinates(query_response)
    address=extract_formatted_address(query_response)
    if outside_united_states?(address)
      return {error: "Unfortunately the National Weather Service only monitors weather in the USA. Enter an American address."}
    end
    {address: address, latitude: coordinates[:latitude], longitude: coordinates[:longitude] }
  end
  

  private

  def self.base_google_url
    "https://maps.googleapis.com/maps/api/geocode/json?"
  end

  def self.headers(address)
    {params: {address: "#{address}", key: ENV["google_api_key"] }}
  end

  def self.extract_coordinates(api_response)
    coordinates=api_response["results"][0]["geometry"]["location"]
    {latitude: coordinates["lat"].to_s, longitude: coordinates["lng"].to_s}
  end

  def self.extract_formatted_address(api_response)
    api_response["results"][0]["formatted_address"]
  end

  def self.query_google_api(address)
    RestClient.get(base_google_url, headers(address))
  end

  def self.parse_api_response(api_response)
    JSON.parse(api_response)
  end

  def self.outside_united_states?(address)
    if address.include? "USA"
      false
    else
      true
    end
  end

end