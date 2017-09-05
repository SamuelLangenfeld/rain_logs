class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :sites

  def update_sites
    self.sites.each do |site|
      site.get_rain
    end
    self.precipitation_updated_at = Time.zone.now
  end
end
