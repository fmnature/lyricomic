class Notification < ApplicationRecord
  default_scope -> {order(created_at: :desc)}

  belongs_to :lyric, optional: true

  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id', optional: true
  belongs_to :sended, class_name: 'User', foreign_key: 'sended_id', optional: true
end
