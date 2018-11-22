class IssuesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "issue_#{params[:issue_id]}"
  end
  def appear(data)
    current_user.appear on: data['appearing_on']
  end
end
