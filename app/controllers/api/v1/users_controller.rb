require 'securerandom'

class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(registration_params)
    user.password_token = SecureRandom.hex
    if user.save
      status = :created
    else
      user   = User.new
      status = :bad_request
    end

    render json: {
      username: user.username,
      email: user.email,
    }, status: status
  end

  def password_token
    user  = User.find_by(id: params[:user_id])
    user.password_token = SecureRandom.hex
    if user.presents?
      status = :created
    else
      user = User.new
      status = :bad_request
    end

    render json: {
      password_token: user.password_token,
    }, status: status
  end

  private

  def registration_params
    params.permit(:username, :email, :password)
  end
end
