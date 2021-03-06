module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id
    elsif cookies_id = cookies.signed[:user_id]
      user = User.find_by id: cookies_id
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def params_session
    params[:session]
  end

  def remember user
    user.remember
    cookies_permanent.signed[:user_id] = user.id
    cookies_permanent[:remember_token] = user.remember_token
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  private

  def cookies_permanent
    cookies.permanent
  end

  def forget user
    user.update_attributes remember_digest: nil
    cookies.delete :user_id
    cookies.delete :remember_token
  end
end
