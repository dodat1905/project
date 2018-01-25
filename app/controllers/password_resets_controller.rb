class PasswordResetsController < ApplicationController
  before_action :find_user, :valid_user,
    :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if user
      reset_password
    else
      flash.now[:danger] = "email_address_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      user.errors.add :password, t("can_be_empty")
      render_edit
    elsif user.update_attributes user_params
      update_password
    else
      render_edit
    end
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def find_user
    @user = User.find_by email: params[:email]

    return if user
    flash[:success] = t "failed_user"
    redirect_to root_path
  end

  def render_edit
    render :edit
  end

  def valid_user
    redirect_to root_url unless check_user
  end

  def check_expiration
    return unless user.password_reset_expired?
    flash[:danger] = t "password_reset_has_expired"
    redirect_to new_password_reset_url
  end

  def reset_password
    user.create_reset_digest
    user.send_password_reset_email
    flash[:info] = t "email_sent_with_password_reset_instructions"
    redirect_to root_url
  end

  def check_user
    user && user.activated? && user.authenticated?(:reset, params[:id])
  end

  def update_password
    log_in user
    flash[:success] = "password_has_been_reset"
    redirect_to user
  end
end
