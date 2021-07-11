class ApplicationController < ActionController::Base

  private

  def authenticate
    if user_id_included_in_auth_token?
      @current_user = User.find(decoded_auth_token[:user_id])
    else
      render json: { success: false, errors: "unauthorized" }, status: 401
    end
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    render json: { success: false, errors: "unauthorized" }, status: 401
  end

  def http_auth_token
    @http_auth_token ||= if request.headers["Authorization"].present?
                           request.headers["Authorization"].split(" ").last
                         end
  end

  def user_id_included_in_auth_token?
    http_auth_token && decoded_auth_token[:user_id]
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_token)
  end
end
