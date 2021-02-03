class Notification < ApplicationRecord
  has_many :active_notifications, class_name: "Notification", foreign_key: "sender_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "sended_id", dependent: :destroy

  default_scope->{order(created_at: :desc)}

  belongs_to :item, optional: true
  belongs_to :comment, optional: true
  belongs_to :sender, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :sended, class_name: 'User', foreign_key: 'visited_id', optional: true
end
