require 'base64'
class Api::V1::VaultsController < ApplicationController
  def index
    user   = User.find_by(id: params[:user_id])
    vaults = user.vaults
    render json: vaults.map { |vault|
      {
        id: vault.id,
        username: vault.username,
        password: vault.password,
        note: vault.note
      }
    }, status: :ok
  end

  def create
    user  = User.find_by(id: params[:user_id])
    vault = Vault.new(create_params)

    unless user.nil?      
      secure_key     = Base64.encode64(params[:password] + user.password_token)
      vault.user     = user
      vault.password = secure_key

      if vault.save
        status = :created
      else
        user   = Vault.new
        status = :bad_request
      end  
    end

    render json: {
      username: vault.username,
      password: vault.password,
      note: vault.note
    }, status: status
  end

  def destroy
    user   = User.find_by(id: params[:user_id])
    vaults = user.vaults

    if vaults.destroy(params[:id])
      status = :ok
    else
      status = :bad_request
    end

    render json: {
      id: params[:id]
    }, status: status
  end

  def update
    user   = User.find_by(id: params[:user_id])
    vaults = user.vaults
    status = :bad_request
    vault  = Vault.new

    unless vaults.empty?
      vault          = vaults.find_by(id: params[:id])
      vault.update_attributes(update_params)
      secure_key     = Base64.encode64(params[:password] + user.password_token)
      vault.password = secure_key

      if vault.save
        status = :ok
      end
    end

    render json: {
      username: vault.username,
      password: vault.password,
      note: vault.note
    }, status: status
  end

  private

  def create_params
    params.permit(:username, :note)
  end

  def update_params
    params.permit(:username, :note)
  end
end
