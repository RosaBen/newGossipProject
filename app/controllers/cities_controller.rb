class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @users = @city.users
    @gossips = Gossip.where(user: @users)
  end

  def index
    @cities = City.all
  end

  def new
    @city = City.new
  end
end
