class UsersController < ApplicationController
  include UsersConcern
  skip_before_action :build_node, except: :edit_profile

  def edit_profile

  end

  def change_password
    if current_user.valid_password?(password_params[:current_password])
      if current_user.update_with_password(password_params)
        @success = "Password Changed Successfully."
        bypass_sign_in(current_user)
      else
        @errors = "something went wrong!"
      end
    else
      @errors = "Current Password does not match.\n"
    end
  end

  def remove_profile_picture
    current_user.profile_picture = nil
    if current_user.save
      redirect_to edit_profile_users_path
    else
      broadcast_flash_message("error", "Something Went Wrong.")
      render edit_profile
    end
  end

  def profile_picture
    current_user.assign_attributes(profile_picture_params)
    if current_user.save
      flash[:success] = "Profile picture changed successfully."
      redirect_to edit_profile_users_path
    else
      broadcast_flash_message("error", "Something Went Wrong.")
      render edit_profile
    end
  end

end
