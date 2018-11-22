class IssuesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "issue_#{params[:issue_id]}"
    ActionCable.server.broadcast("issue_#{params[:issue_id]}", {
      current_user_id: current_user.id,
      action: "subscribed"
    })
  end

  def unsubscribed
    # ActionCable.server.broadcast("issue_#{issue.id}", {
    #   current_user_id: current_user.id,
    #   action: "unsuscribed"
    # })
  end
  def appear(data)
    current_user.appear on: data['appearing_on']
  end
end
