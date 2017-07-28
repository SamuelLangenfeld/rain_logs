require 'rails_helper'

RSpec.describe Site, :type => :model  do

  let(:valid_user) {
    user=User.new()
    user.email="example@example.com"
    user.password=password
    user.save
    user
  }

  context "user enters address outside of United States" do
    foreign_site=Site.new()
    foreign_site.address="Eiffel Tower"
    it "raises an error" do
      expect{siting.get_site_attributes}.to raise_error(StandardError)
    end
  end

  context "user enters united states address" do
    valid_site=Site.new()
    valid_site.address="1600 Pennsylvania Avenue Washington, DC"
    valid_site.user_id= valid_user.id
    it "is a valid site" do
    end
  end

end