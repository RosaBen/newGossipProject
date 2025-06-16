class GossipsController < ApplicationController
  # puts "PARAMS ----------"
  # puts params.inspect
  # puts ""
  def index
    @gossips = Gossip.includes(:user).order(created_at: :desc)
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end
  def create
    # puts "&&&&&&&&&&&&&&&&&&&&"
    # puts "PARAMS: #{params.inspect}"
    # puts "&&&&&&&&&&&&&&&&&&&&"
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user
    if @gossip.save
      flash[:notice] = "✅ Gossip bien créé !"
      redirect_to gossip_path(@gossip)
    else
      flash.now[:alert] = "❌ Remplis bien tous les champs."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end
  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(gossip_params)
      flash[:notice] = "✅ Gossip bien modifié !"
      redirect_to gossip_path(@gossip)
    else
      flash.now[:alert] = "❌ Remplis bien tous les champs."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    if @gossip.destroy
      flash[:notice] = "✅ Gossip bien supprimé !"
      redirect_to gossips_path
    else
      flash[:alert] = "❌ Une erreur est survenue lors de la suppression du gossip."
      redirect_to gossip_path(@gossip), status: :unprocessable_entity
    end
  end


  private
  # puts "PARAMS ----------"
  # puts params.inspect
  # puts "-----------------"
  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end
end
