class UsersController < ApplicationController
    def create
        user = User.create(user_params)
        
        if user.valid?
          session[:user_id] = user.id
          render json: user, status: :unprocessable_entity
        else
          render json: { error: user.errors}, status: 422
        end
      end
    
    def show
        if current_user
          render json: current_user
        else
          head :unauthorized
        end
    end
    
      private
    
    def user_params
        params.permit(:username, :password)
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end   
end
