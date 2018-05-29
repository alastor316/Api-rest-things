class Api::SessionsController < ApplicationController

before_action :resource

  def create

    if resource.is_password?(params[:password])

      auth_token = resource.generate_auth_token
      render json: { auth_token: auth_token }
    else
      invalid_login_attempt
    end

  end


  def destroy
    resource = current_person
    resource.invalidate_auth_token
    head :ok
  end


  private

    def invalid_login_attempt
      render json: { errors: [ { detail:"Error with your login or password" }]}, status: 401
    end

    def resource
    
    resource = Usuario.find_by(:mail => params[:mail])
    resource ||= Usuario.new

    end

  end