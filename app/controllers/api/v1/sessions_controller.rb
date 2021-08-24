require 'securerandom'

class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(login_params)
    if user && user.authenticate(params[:password])
      session[:user_email] = user.email
      status = :created
    else
      user = User.new
      status = :unauthorized
    end

    render json: {
      username: user.username,
      email: user.email
    }, status: status 
  end

  def destroy
    user = User.find_by(login_params)

    if user && session[:user_id] == user.id
      session[:user_id] = nil
      status = :ok
    else
      user = User.new
      status = :unauthorized
    end

    render json: {
      username: user.username,
      email: user.email
    }, status: status 
  end

  private

  def login_params
    params.permit(:email)
  end

  def logout_params
    params.permit(:email)
  end
end
