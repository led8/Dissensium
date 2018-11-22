class IssuesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "issue_#{params[:issue_id]}"
    ConnectedList.add(uid)
  end

  def unsubscribed
    ConnectedList.remove(uid)
  end
end
