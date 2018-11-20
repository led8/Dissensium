class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ChatRoom"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
