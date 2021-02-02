class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lyrics
  has_many :comments
  has_many :likes

  validates :profile, length: { maximum: 250 }
  validate :image
  mount_uploader :image, ImageUploader

  def already_liked?(lyric)
    self.likes.exists?(lyric_id: lyric.id)
  end
end
