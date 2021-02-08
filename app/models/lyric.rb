class Lyric < ApplicationRecord
  validates :word, presence: true
  belongs_to :user

  has_many :comments
  has_many :likes
  has_many :notifications, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  has_one_attached :image

  validates :word, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end

  def self.search(search)
    if search != ""
      Lyric.where('word LIKE(?)', "%#{search}%")
    else
      Lyric.all
    end
  end

  def create_notification_like!(current_user)
    temp = Notification.where(["sender_id = ? and sended_id = ? and lyric_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        lyric_id: id,
        sended_id: user_id,
        action: 'like'
      )
      if notification.sender_id == notification.sended_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(lyric_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, sended_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      lyric_id: id,
      comment_id: comment_id,
      sended_id: sended_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.sender_id == notification.sended_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
