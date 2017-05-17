class SitesController < ApplicationController

  def new
    @site=Site.new
  end

  def show
    @site=Site.find(params[:id])
  end

  def create
    @site = Site.new(site_params)
    base_google_url="https://maps.googleapis.com/maps/api/geocode/json?"
    headers={params: {address: "#{@site.address}", key: ENV["google_api_key"] }}
    feedback = RestClient.get(base_google_url, headers)
    json_answer=JSON.parse(feedback)
    unless json_answer["results"][0]["formatted_address"].include? "USA"
      flash[:notice]= "Unfortunately the National Weather Service only monitors weather in the USA. Enter an American address."
      return
    end
    location= json_answer["results"][0]["geometry"]["location"]
    @site.latitude= location["lat"].to_s
    @site.longitude= location["lng"].to_s

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site.user, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { redirect_to User.find(@site.user_id) }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
    @site=Site.find(params[:id])
    @site.destroy
    respond_to do |format|
      format.html { redirect_to user_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_rain
    @site=Site.find(params[:id])
    @site.get_rain
    redirect_to @site
  end

  private
    def site_params
      params.require(:site).permit(:user_id, :name, :geo_location, :address, :latest_precip, :station)
    end
end
