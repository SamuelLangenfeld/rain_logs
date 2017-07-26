class Site < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  def get_rain
    precipitation=NWSAPICaller.new.get_precipitation_data(self.station_id)
    update_site_precip_data(precipitation)
  end


  def get_site_attributes
    google_location_info=GoogleAPICaller.new.get_location_info(self.address)
    begin
      if google_location_info[:error]
        raise StandardError.new("Unfortunately the National Weather Service only monitors weather in the USA. Enter an American address.")
      end
    #rescue StandardError =>e
     # puts e.message
      #return
    end
    self.address= google_location_info[:address]
    self.latitude= google_location_info[:latitude]
    self.longitude= google_location_info[:longitude]
    self.station_id= NWSAPICaller.new.get_station_id(self.latitude, self.longitude)
    self
  end

  private

  def update_site_precip_data(precip)
    self.week_precip=precip[:week_precip]
    self.latest_precip=precip[:day_precip]
    self.last_update=Time.zone.now
    self.save
  end

end