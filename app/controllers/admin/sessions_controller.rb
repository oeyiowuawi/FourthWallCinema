class Admin::SessionsController < ApplicationController
 
  def create
    user = User.find_by(email: user_params[:email])
    if user.present?
      process_authentication_for user 
    else
      render json: { success: false, message: " Email or password not correct." },
             status: 401
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def process_authentication_for(user)
    if user.authenticate(user_params[:password])
      payload = { user_id: user.id, email: user.email }
      token = JsonWebToken.encode(payload)
      render json: { success: true, token: token }, status: 201
    else
      render json: { success: false, message: " Email or password not correct." },
             status: 401
    end
  end
end