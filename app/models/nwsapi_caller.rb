class NWSAPICaller < ApplicationRecord

  def get_station_id(latitude, longitude)
    extract_station_id(call_api(latitude, longitude))
  end

  def get_precipitation_data(station_id)
    format_precip_data(extract_precip_data(query_weather(station_id)))
  end

  

  private

  def weather_url(latitude, longitude)
    "https://api.weather.gov/points/"+latitude+","+longitude+"/stations"
  end

  def station_url(station_id)
    "https://api.weather.gov/stations/"+station_id+"/observations"
  end

  def call_api(latitude, longitude)
    RestClient.get(weather_url(latitude, longitude))
  end

  def extract_station_id(feedback)
    JSON.parse(feedback)["features"][0]["properties"]["stationIdentifier"]
  end

  def query_weather(station_id)
    JSON.parse(RestClient.get(station_url(station_id)))
  end

  def extract_precip_data(raw_data)
    day_precip=0.0
    raw_data["features"].take(24).each do |feature|
      day_precip+=feature["properties"]["precipitationLastHour"]["value"].to_f
    end
    week_precip=0.0
    raw_data["features"].take(168).each do |feature|
      week_precip+=feature["properties"]["precipitationLastHour"]["value"].to_f
    end
    {week_precip: week_precip, day_precip: day_precip}
  end

  def format_precip_data(precip)
    precip.each do |k,v|
      precip[k]=convert_from_meters_to_inches(v)
      precip[k]=sprintf "%.2f", precip[k].round(2)
    end
    precip
  end

  def convert_from_meters_to_inches(meters)
    meters*39.3701
  end

end
