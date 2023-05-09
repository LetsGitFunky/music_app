class UsersController < ApplicationController
        # can only create user if logged out
        before_action :require_logged_out, only: [:new, :create]
        # can only see this pages if logged in
        before_action :require_logged_in, only: [:show]

    def index
        @users = User.all
        render :index
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login!(@user)
            redirect_to user_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :session_token, :password_digest)
    end
end
