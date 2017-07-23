class SitesController < ApplicationController

  def new
    @site=Site.new
  end

  def show
    @site=Site.find(params[:id])
    @site.get_rain
  end

  def create
    @site = Site.new(site_params)
    @site.get_site_attributes

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

  private
    def site_params
      params.require(:site).permit(:user_id, :name, :geo_location, :address, :latest_precip, :station)
    end
end
