class UsersController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Vous êtes maintenant un gossipper!"
      redirect_to gossips_path
    else
      flash.now[:error] = "Nous n'avons pas pu vous enregistrer."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    # puts "PARAMS ----------"
    # puts params.inspect
    # puts "-----------------"
    params.require(:user).permit(:pseudo, :email, :password, :password_confirmation, :bio, :city_id)
  end
end
