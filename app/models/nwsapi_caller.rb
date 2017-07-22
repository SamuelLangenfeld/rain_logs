class NWSAPICaller < ApplicationRecord

  def get_station_id(latitude, longitude)
    extract_station_id(call_api(latitude, longitude))
  end

  private

  def weather_url(latitude, longitude)
    "https://api.weather.gov/points/"+latitude+","+longitude+"/stations"
  end

  def call_api(latitude, longitude)
    RestClient.get(weather_url(latitude, longitude))
  end

  def extract_station_id(feedback)
    JSON.parse(feedback)["features"][0]["properties"]["stationIdentifier"]
  end

end
