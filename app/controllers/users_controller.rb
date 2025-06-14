class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    puts "PARAMS ----------"
    puts params.inspect
    puts "-----------------"
    @user = User.find(params[:id])
  end

  private

  def user_params
    puts "PARAMS ----------"
    puts params.inspect
    puts "-----------------"
    params.require(:user).permit(:pseudo, :email, :password, :bio)
  end
end
