class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation,
      params[:id])
      success_activated user
    else
      invalid_activation
    end
  end

  private

  def success_activated user
    user.activate
    log_in user
    flash[:success] = t "account_activated"
    redirect_to user
  end

  def invalid_activation
    flash[:danger] = t "invalid_activation_link"
    redirect_to root_url
  end
end
