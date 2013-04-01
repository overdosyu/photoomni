class UserProfilesController < ApplicationController
  before_filter :find_or_create_user_profile, only: [:edit, :update]

  def edit
  end

  def update
    if @user_profile.update_attributes(params[:user_profile])
      flash[:notice] = "Successfully updated profile."
    else
      flash[:error] = "Fail to update profile."
    end
    render :action => 'edit'
  end

  private

  def find_or_create_user_profile
    @user_profile = UserProfile.find_or_create_by_user_id(current_user.id)
  end

end
