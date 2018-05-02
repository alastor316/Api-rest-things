  module Token
  	def require_login!
	    return true if authenticate_token
	    render json: { errors: [ { detail: "Access denied" } ] }, status: 401
  	end

    def require_admin!
      return true if current_user.privilegio == "Administrador"
      jsonerror_response(current_user.privilegio,"Debes ser administrador para realizar esta accion")
    end

  	def current_user
    	@current_user
  	end

  		private
    def authenticate_token

      authenticate_with_http_token do |token, options|
         @current_user = Usuario.where(auth_token: token).where("token_created_at >= ?", 1.month.ago).first
		 @current_user.update_ultimaconexion if @current_user
		 return @current_user      	
      end
    end 
end