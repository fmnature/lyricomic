class Lyric < ApplicationRecord
  validates :word, presence: true
  belongs_to :user

  has_many :comments
  has_many :likes
  has_many :notifications, dependent: :destroy

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
    # すでに「いいね」されているか検索
    temp = Notification.where(["sender_id = ? and sended_id = ? and lyric_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        lyric_id: id,
        sended_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.sender_id == notification.sended_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
