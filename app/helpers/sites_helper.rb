
module SitesHelper
  def format_address_for_google_query(address)
    address.gsub ' ', '+'
  end
end
