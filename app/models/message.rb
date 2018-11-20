class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user
  validates :content, presence: true, allow_blank: false

  after_create :broadcast_message

  def from?(some_user)
    user == some_user
  end
end
