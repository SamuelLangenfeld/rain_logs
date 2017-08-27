require 'rails_helper'

RSpec.describe NWSAPICaller, type: :model do

  before(:all) do
    @precipitation_data=NWSAPICaller.get_precipitation_data("KDCA")
  end

  describe "get_station_id" do
    it "returns the correct observation station id for the lat/long given" do
      expect(NWSAPICaller.get_station_id("38.8977","-77.0365")).to eq("KDCA")
    end
  end

  describe "get_precipitation_data" do
    

    it "returns a hash of precipitation data if given an observation station id" do
      expect(@precipitation_data).to be_instance_of(Hash)
    end

    it "returns a hash with a day_pecip string" do
      expect(@precipitation_data[:week_precip]).to be_instance_of(String)
    end

    it "returns a hash with a day_pecip string" do
      expect(@precipitation_data[:day_precip]).to be_instance_of(String)
    end
  end


end
