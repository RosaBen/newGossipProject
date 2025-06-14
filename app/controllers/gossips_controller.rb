class GossipsController < ApplicationController
  def index
    @gossips = Gossip.order(created_at: :desc)
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content, :author_id) # Ajout author_id pour éviter warning
  end
end
