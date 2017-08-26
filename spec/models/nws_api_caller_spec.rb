require 'rails_helper'

RSpec.describe NWSAPICaller, type: :model do
  
  FactoryGirl.define do
    factory :NWSAPICaller do
    end
  end

  describe "get_station_id" do
    it "returns the correct observation station id for the lat/long given" do
      new_caller=build(:NWSAPICaller)
      expect(new_caller.get_station_id("38.8977","-77.0365")).to eq("KDCA")
    end
  end

  describe "get_precipitation_data" do
    

    it "returns a hash of precipitation data if given an observation station id" do
      new_caller=build(:NWSAPICaller)
      expect(new_caller.get_precipitation_data("KDCA")).to be_instance_of(Hash)
    end

    it "returns a hash with a day_pecip string" do
      new_caller=build(:NWSAPICaller)
      new_hash=new_caller.get_precipitation_data("KDCA")
      expect(new_hash[:week_precip]).to be_instance_of(String)
    end

    it "returns a hash with a day_pecip string" do
      new_caller=build(:NWSAPICaller)
      new_hash=new_caller.get_precipitation_data("KDCA")
      expect(new_hash[:day_precip]).to be_instance_of(String)
    end
  end


end
