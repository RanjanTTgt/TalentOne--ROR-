class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :validate_user, only: :create

  def create
    auth_header = cookies[:token] || request.headers['Authorization']
    puts "auth_header = #{auth_header}"
    return if missing_params!([:email, :password])
    user = User.find_by(email: params[:email].downcase)
    if user && user.valid_password?(params[:password])
      if user.status
        auth_token = JsonWebToken.encode({ user_id: user.id }, 7.days.from_now.to_i)
        cookies[:token] = { value: auth_token, expires: 7.days.from_now }
        render_serialize_data(serializer: Api::V1::UserSerializer,
                              obj: user,
                              message: "Successfully Logged In",
                              meta: { auth_token: auth_token })
      else
        render_unauthorized(message: "Your account is not inactive",
                            errors: [{ field: "password", message: "Your account is not inactive" }])
      end
    else
      render_unauthorized(message: "Whoops! The email or password is not correct",
                          errors: [{ field: "password", message: "Whoops! The email or password is not correct" }])
    end
  end

  def destroy
    cookies[:token] = nil
    render_success(message: "Logged out successfully")
  end

end
