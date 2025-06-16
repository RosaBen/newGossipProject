class GossipsController < ApplicationController
  # puts "PARAMS ----------"
  # puts params.inspect
  # puts ""
  def index
    @gossips = Gossip.includes(:user, :tags).order(created_at: :desc)
  end

  def show
    @gossip = Gossip.includes(:tags).find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end
  def create
    # puts "&&&&&&&&&&&&&&&&&&&&"
    # puts "PARAMS: #{params.inspect}"
    # puts "&&&&&&&&&&&&&&&&&&&&"
    @gossip = Gossip.new(gossip_params)
    if current_user
      @gossip.user = current_user
      if @gossip.save
        handle_new_tag(@gossip)
        flash[:notice] = "✅ Gossip bien créé !"
        redirect_to gossip_path(@gossip)
      else
        flash.now[:alert] = "❌ Remplis bien tous les champs."
        render :new, status: :unprocessable_entity
      end
    else
      flash[:alert] = "❌ Vous devez être connecté pour créer un gossip."
      redirect_to new_session_path
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end
  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(gossip_params)
      handle_new_tag(@gossip)
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
    params.require(:gossip).permit(:title, :content, tag_ids: [])
  end

  def handle_new_tag(gossip)
    new_tag_name = params[:new_tag_name].to_s.strip
    return if new_tag_name.blank?

    tag = Tag.find_or_create_by(name: new_tag_name)
    gossip.tags << tag unless gossip.tags.include?(tag)
  end
end
