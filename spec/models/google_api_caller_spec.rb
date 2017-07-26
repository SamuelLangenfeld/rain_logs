require 'rails_helper'

RSpec.describe GoogleAPICaller, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "get_location_info" do
    it "returns the correct latitude" do
      puts (GoogleAPICaller.new.get_location_info("6369 lakewood dr falls church va")["address"])
      expect(GoogleAPICaller.new.get_location_info("the white house")).to be true
    end

    it "returns the correct longitude" do
    end
  end
end
