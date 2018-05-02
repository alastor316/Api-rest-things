class ApplicationController < ActionController::API
  include Json
  include Server
  include Token
  include ExceptionHandler
  include ActionController::HttpAuthentication::Token::ControllerMethods
  		
end
