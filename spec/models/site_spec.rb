require 'rails_helper'

RSpec.describe Site, :type => :model  do


  FactoryGirl.define do
    factory :site do
    end
    factory :user do
    end
  end

  it "requires User to validate" do
    expect{create(:site)}.to raise_error(StandardError)
  end

  describe "get_site_attributes" do

    context "user enters address outside of United States" do
      it "raises an error" do
        foreign_site=build(:site)
        foreign_site.address="Eiffel Tower"
        expect{foreign_site.get_site_attributes}.to raise_error(StandardError)
      end
    end

    context "user enters united states address" do
      it "is a valid site" do
        valid_site=build(:site)
        valid_site.address="1600 Pennsylvania Avenue Washington, DC"
        expect{valid_site.get_site_attributes}.to_not raise_error
      end

      it "returns the site with address, longitude, latitude, and station id attributes assigned" do
        new_site=build(:site)
        new_site.address="1600 Pennsylvania Avenue Washington, DC"
        returned_site=new_site.get_site_attributes
        expect(returned_site).to be_instance_of(Site)
        expect(returned_site.address).to be_truthy
        expect(returned_site.longitude).to be_truthy
        expect(returned_site.latitude).to be_truthy
        expect(returned_site.station_id).to be_truthy
      end
    end

  end

  describe "get_rain" do

    let(:make_site) do
      new_site=build(:site)
      new_site.address="1600 Pennsylvania Avenue Washington, DC"
      new_site.get_site_attributes
      new_site.get_rain
      new_site
    end

    it "gets a value for the site's daily rainfall" do
      new_site=make_site
      expect(new_site.latest_precip).to be_truthy
    end

    it "gets a value for the site's weekly rainfall" do
      new_site=make_site
      expect(new_site.week_precip).to be_truthy
    end
    
  end

end