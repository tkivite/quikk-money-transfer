class ApplicationController < ActionController::API

 # Authenticate all requests
 before_action :authenticate_request

 attr_reader :current_user

 private

 def authenticate_request
   @current_user = AuthorizeApiRequest.call(request.headers).result
   unless @current_user
     render json: { error: 'Not Authenticated' }, status: 401
   end
 end
end
