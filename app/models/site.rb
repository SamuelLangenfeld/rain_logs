class Site < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  def get_rain
    weather_url="https://api.weather.gov/points/"+self.latitude+","+self.longitude+"/stations"
    feedback = RestClient.get(weather_url)
    json_answer=JSON.parse(feedback)
    self.station_id=json_answer["features"][0]["properties"]["stationIdentifier"]
    station_url="https://api.weather.gov/stations/"+self.station_id+"/observations"
    feedback=RestClient.get(station_url)
    json_answer=JSON.parse(feedback)
    precip=0.0
    if json_answer["features"][0]["properties"].key? "precipitationLastHour"
      json_answer["features"].take(24).each do |feature|
        precip+=feature["properties"]["precipitationLastHour"]["value"].to_f
      end
      precip=precip*39.3701
      precip=sprintf "%.2f", precip.round(2)
      self.latest_precip=precip.to_s

      precip=0.0
      json_answer["features"].take(168).each do |feature|
        precip+=feature["properties"]["precipitationLastHour"]["value"].to_f
      end
      precip=precip*39.3701
      precip=sprintf "%.2f", precip.round(2)
      self.week_precip=precip.to_s
      self.last_update=Time.zone.now
    else
      nil
    end
    self.save
  end
end
