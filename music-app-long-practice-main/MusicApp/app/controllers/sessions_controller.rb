class SessionsController < ApplicationController
    # can only login if we arent already logged in
    before_action :require_logged_out, only: [:new, :create]
    # can only logout if we arent already logged out
    before_action :require_logged_in, only: [:destroy]

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

        if @user.save
            login!(@user)
            redirect_to user_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end
