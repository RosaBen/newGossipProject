class GossipTag < ApplicationRecord
  belongs_to :gossip
  belongs_to :tag
  validates :gossip_id, uniqueness: { scope: :tag_id }
end
