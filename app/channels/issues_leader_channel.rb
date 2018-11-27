class IssuesLeaderChannel < ApplicationCable::Channel
  def subscribed
    issue = Issue.find(params[:issue_id])
    return unless issue.owned_by?(current_user)
    stream_from "issue_leader_#{params[:issue_id]}"
    ActionCable.server.broadcast("issue_#{params[:issue_id]}", {
      current_user_id: current_user.id,
      action: "subscribed",
      user_partial: ApplicationController.renderer.render(
        partial: "issues/user_icon.html",
        locals: { user: self, user_is_users_author: false, current_user_id: current_user.id}
      )
    })
    ActionCable.server.broadcast("issue_leader_#{params[:issue_id]}", {
      current_user_id: current_user.id,
      action: "subscribed",
      user_partial: ApplicationController.renderer.render(
        partial: "issues/user_icon.html",
        locals: { user: self, user_is_users_author: false, current_user_id: current_user.id}
      )
    })
  end

  def unsubscribed
    # ActionCable.server.broadcast("issue_#{issue.id}", {
    #   current_user_id: current_user.id,
    #   action: "unsuscribed"
    # })
  end
end
