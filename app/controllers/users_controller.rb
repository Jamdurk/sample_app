class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def index 
    @users = User.where(activated: true).page(params[:page]).per(10)
  end

  def show 
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(10)
    redirect_to root_url and return unless @user.activated?
  end
  

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info]= "Please check your email to activate your account BITCH."
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end 

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated!"
      redirect_to @user
    else 
      render 'edit', status: :unprocessable_entity
    end
  end 

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10)
    render 'show_follow'
  end

   def followers 
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_follow'
  end

    private 

    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end  
    