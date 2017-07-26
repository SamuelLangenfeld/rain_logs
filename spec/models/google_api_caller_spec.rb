require 'rails_helper'

RSpec.describe GoogleAPICaller, type: :model do

  describe "get_location_info" do

    

    context "if given a valid place" do

      googleResponse= GoogleAPICaller.new.get_location_info("the white house")

      it "returns a hash with values for longitude, latitude, and address" do
        expect(googleResponse).to be_instance_of(Hash)
      end

      it "returns the correct latitude" do
        expect(googleResponse[:latitude]).to eq("38.8976763")
      end

      it "returns the correct longitude" do
        expect(googleResponse[:longitude]).to eq("-77.0365298")
      end

      it "returns the correct address" do
        expect(googleResponse[:address]).to include("1600 Pennsylvania")
      end

      it "has no error key in the return hash" do
        expect(googleResponse[:error]).to be_nil
      end
    end
    

    context "if given location outside of the United States" do
      googleResponse= GoogleAPICaller.new.get_location_info("Eiffel Tower")
    

      it "returns an error key/value pair in the hash" do
        expect(googleResponse[:error]).to be_truthy
      end
    end


  end
end   