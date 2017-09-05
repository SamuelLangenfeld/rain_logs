class UsersController < ApplicationController
  def show
    @user=current_user
    if @user.precipitation_updated_at
      if (Time.zone.now - current_user.precipitation_updated_at).to_i/1.day > 1
        current_user.update_sites
      end
    else
      @user.update_sites
    end
    @user.save
  end

  def create
    @user = User.new(params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to User.find(@site.user_id) }
        @user.errors.each do |error|
          puts error.to_s
        end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def immediate_update
    @user = current_user
    @user.update_sites
    @user.save
    redirect_to @user
    flash[:notice] = "Your sites have been updated"
  end
end
