class SessionsController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]
  def new
  end

  def create
    @user = User.find_by_email_or_pseudo(params[:email_or_pseudo])
    if @user && @user.authenticate(params[:password])
      login(@user)
      if params[:remember_me] == "1"
        remember(@user)
      else
        forget(@user)
      end
      flash[:success] = "Bienvenue #{@user.pseudo} !"
      redirect_to gossips_path
    else
      flash.now[:alert] = "Identifiant ou mot de passe incorrect."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout(current_user)
    flash[:success] = "Vous avez été déconnecté."
    redirect_to root_path
  end
end
