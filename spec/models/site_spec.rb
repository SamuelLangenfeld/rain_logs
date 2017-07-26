require 'rails_helper'

RSpec.describe Site, :type => :model  do
  siting=Site.new()
  siting.address="Eiffel Tower"
  it "raises error if outside US" do
    expect{siting.get_site_attributes}.to raise_error
  end
end