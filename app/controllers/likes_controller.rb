class LikesController < ApplicationController
  before_action :set_gossip

  def create
    @like = @gossip.likes.find_by(user: current_user)

    if @like
      @like.destroy
    else
      @gossip.likes.create(user: current_user)
    end

    @gossip.reload

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "like_section_#{@gossip.id}",
          partial: "shared/like_button",
          locals: { gossip: @gossip }
        )
      end
      format.html { redirect_to gossips_path(@gossips) }
    end
  end

  private

  def set_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end
end
