module UsersConcern
  extend ActiveSupport::Concern

  private

  def password_params
    params.require(:change_password).permit(:password, :current_password)
  end

  def profile_picture_params
    params.require(:profile).permit(:profile_picture)
  end

end
