class PasswordResetsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            PasswordMailer.with(user: @user).reset.deliver_now # TODO: deliver_later?
            redirect_to root_path, notice: "Password reset email sent to #{params[:email]}."
        else
            render :new, status: :unprocessable_entity, notice: "No account associated with that email."
        end
    end

    def edit
        @user = User.find_signed!(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to login_path, notice: "Your token has expired. Please try again."
    end

    def update
        @user = User.find_signed!(params[:token], purpose: "password_reset")

        if @user.update(password_params)
            redirect_to login_url, notice: "Password was successfully updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private
        def password_params
            params.require(:user).permit(
                :password,
                :password_confirmation
            )
        end
end