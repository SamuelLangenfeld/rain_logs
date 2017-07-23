class Site < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  def get_rain
    precipitation=extract_precip_data(query_weather)
    update_site_precip_data(format_precip_data(precipitation))
  end


  def get_site_attributes
    google_location_info=GoogleAPICaller.new.get_location_info(self.address)
    if google_location_info[:error]
      return false
    end
    self.address= google_location_info[:address]
    self.latitude= google_location_info[:latitude]
    self.longitude= google_location_info[:longitude]
    self.station_id= NWSAPICaller.new.get_station_id(self.latitude, self.longitude)
    self
  end

  private

  def query_weather
    JSON.parse(RestClient.get(station_url(self.station_id)))
  end

  def station_url(station_id)
    "https://api.weather.gov/stations/"+station_id+"/observations"
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

  def convert_from_meters_to_inches(meters)
    meters*39.3701
  end

  def format_precip_data(precip)
    precip.each do |k,v|
      precip[k]=convert_from_meters_to_inches(v)
      precip[k]=sprintf "%.2f", precip[k].round(2)
    end
    precip
  end

  def update_site_precip_data(precip)
    self.week_precip=precip[:week_precip]
    self.latest_precip=precip[:day_precip]
    self.last_update=Time.zone.now
    self.save
  end

end
