class GossipsController < ApplicationController
  def index
    @gossips = Gossip.order(created_at: :desc)
  end
end
