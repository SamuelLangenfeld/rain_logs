class Site < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  def get_rain
    station_url="https://api.weather.gov/stations/"+self.station_id+"/observations"
    feedback=RestClient.get(station_url)
    json_answer=JSON.parse(feedback)
    day_precip=0.0
    if json_answer["features"][0]["properties"].key? "precipitationLastHour"
      json_answer["features"].take(24).each do |feature|
        day_precip+=feature["properties"]["precipitationLastHour"]["value"].to_f
      end
      meters_to_inches_conversion_factor=39.3701
      day_precip=day_precip*meters_to_inches_conversion_factor
      day_precip=sprintf "%.2f", day_precip.round(2)
      self.latest_precip=day_precip.to_s

      week_precip=0.0
      json_answer["features"].take(168).each do |feature|
        week_precip+=feature["properties"]["precipitationLastHour"]["value"].to_f
      end
      week_precip=week_precip*meters_to_inches_conversion_factor
      week_precip=sprintf "%.2f", week_precip.round(2)
      self.week_precip=week_precip.to_s
      self.last_update=Time.zone.now
    else
      nil
    end
    self.save
  end
end
