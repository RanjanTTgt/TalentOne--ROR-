class Api::V1::BaseController < ActionController::API
  include Pagy::Backend
  include ResponseRenderer
  include MissingData
  include JsonWebToken
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_bad_request
  rescue_from ActiveRecord::RecordNotUnique, with: :render_not_unique_response
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from JWT::DecodeError, with: :jwt_invalid_token
  rescue_from JWT::ExpiredSignature, with: :jwt_invalid_token
  rescue_from JWT::InvalidIssuerError, with: :jwt_invalid_token
  rescue_from JWT::VerificationError, with: :jwt_verification_error

  before_action :validate_user, except: :route_not_found

  def route_not_found
    render json: { success: false, message: "Invalid URL", status_code: 404 }, status: 404
  end

  protected

  def validate_user
    @decode_token ||= decode_token
    puts @decode_token
    unless @decode_token.present?
      return render_error(message: "Missing Authentication Token",
                          errors: [{ field: "token", message: "Missing Authentication Token" }],
                          status_code: 403)

    end

    if @decode_token.present?
      @current_user ||= User.find_by(id: @decode_token['user_id'])
    end

    unless @current_user.present?
      render_unauthorized(message: 'Invalid User')
    end
  end

  private

  def decode_token
    puts cookies[:token]
    auth_header = cookies[:token] || request.headers['Authorization']
    token = auth_header.present? ? auth_header.split(' ').last : nil
    if token.present?
      JsonWebToken.decode(token) if token.present?
    else
      cookies[:token] = nil
    end
  end

  def current_user
    @current_user
  end

end
