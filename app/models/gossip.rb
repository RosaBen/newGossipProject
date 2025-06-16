class Gossip < ApplicationRecord
  belongs_to :user
  has_one_attached :media
  has_many :comments, dependent: :destroy
  has_many :gossip_tags, dependent: :destroy
  has_many :tags, through: :gossip_tags
  has_many :likes
has_many :liking_users, through: :likes, source: :user
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 3, maximum: 1000 }
end
