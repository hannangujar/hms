class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id
                redirect_to root_path, notice: 'User was successfully created.'
            else
                #render :new 
                # or
                 format.html { redirect_to  signup_path }
            end
    end

    private

    def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :password , :password_confirmation)
    end
end