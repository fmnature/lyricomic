class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  has_many :lyrics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :relationships, foreign_key: "user_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user, dependent: :destroy

  # ユーザーと通知モデルの紐付け
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'sender_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'sended_id', dependent: :destroy

  validates :profile, length: { maximum: 250 }
  validates :nickname, presence: true
  validate :image
  mount_uploader :image, ImageUploader

  validates :category_id, numericality: { other_than: 1 } 

  def already_liked?(lyric)
    self.likes.exists?(lyric_id: lyric.id)
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["sender_id = ? and sended_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        sended_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
