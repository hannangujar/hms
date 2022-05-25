class PasswordResetsController < ApplicationController
    def new
    
    end

    def create
        @user = User.find_by(email: params[:email])
         if @user.present?
            #send email
            PasswordMailer.with(user: @user).reset.deliver_now
         end
         redirect_to root_path, notice: "If an account with that email was found, we have sent alink to reset your password"
    end
    def edit
        @user = User.find_signed!(params[:token], purpose: "password_rest")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to signin_path, notice: "Your token has expired, Please Try again"
    end
    def update
        @user = User.find_signed!(params[:token], purpose: "password_rest")
        if @user.update(passsword_params)
            redirect_to signin_path, notice: "Your password was reset successfully,Please Sign in"  
        else
            render :edit
        end  
    end

    private

    def password_params
        parms.require(:user).permit(:password, :password_confirmation)
    end
end