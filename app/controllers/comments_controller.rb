class CommentsController < ApplicationController
  before_action :set_gossip
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Commentaire ajouté avec succès."
    else
      flash[:alert] = "Erreur : commentaire non valide."
    end
    redirect_to gossip_path(@gossip)
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Commentaire mis à jour !"
      redirect_to gossip_path(@gossip)
    else
      flash[:alert] = "Erreur lors de la mise à jour."
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Commentaire supprimé."
    redirect_to gossip_path(@gossip)
  end


  private

  def set_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end

  def set_comment
    @comment = @gossip.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
