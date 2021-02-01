class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lyrics
  has_many :comments

  validates :profile, length: { maximum: 250 }
  mount_uploader :image, ImageUploader
end
