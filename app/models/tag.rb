class Tag < ApplicationRecord
  has_many :gossip_tags, dependent: :destroy
  has_many :gossips, through: :gossip_tags
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
end
