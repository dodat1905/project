class UsersController < ApplicationController
  attr_reader :user, :microposts

  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :find_user, only: %i(edit show update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.activated.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if user.save
      UserMailer.account_activation(user).deliver_now
      flash[:info] = t "please_check_your_email_to_activate_your_account"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @microposts = user.microposts.desc.paginate page: params[:page]
    @supports = Supports::User.new user: user, current_user: current_user, followed_id: user.id
  end

  def edit; end

  def update
    if user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to user
    else
      render :edit
    end
  end

  def destroy
    user.destroy
    flash[:success] = t "user_deleted"
    redirect_to users_url
  end

  private

  def active_relationships
    current_user.active_relationships
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :age, :address
  end

  def correct_user
    redirect_to root_path unless user.current_user? current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    flash[:success] = t "failed_user"
    redirect_to root_path
  end
end
