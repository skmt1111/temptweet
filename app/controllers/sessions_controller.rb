class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from_auth_hash(auth)

    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: 'ログインしました'
    else
      redirect_to root_url, alert: 'ログインに失敗しました'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
