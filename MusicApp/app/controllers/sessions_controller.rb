class SessionsController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:destroy]


    def create
        user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )

        if user.nil?
            flash.now[:errors] = ["Invalid credentials"]
            render :new
        else
            login!(user)
            redirect_to user_url(@user)
        end

        def destroy
            logout!
            redirect_to new_session_url
        end
    end
end