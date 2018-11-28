class IssuesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "issue_#{params[:issue_id]}"
    ActionCable.server.broadcast("issue_#{params[:issue_id]}", {
      current_user_id: current_user.id,
      action: "subscribed",
      user_partial: ApplicationController.renderer.render(
        partial: "issues/user_icon.html",
        locals: { user: self,
                  user_is_users_author: false,
                  current_user_id: current_user.id,
                  current_user_username: current_user.username }
      )
    })
    ActionCable.server.broadcast("issue_leader_#{params[:issue_id]}", {
      current_user_id: current_user.id,
      current_user_username: current_user.username,
      action: "subscribed",
      user_partial: ApplicationController.renderer.render(
        partial: "issues/user_icon.html",
        locals: { user: self,
                  user_is_users_author: false,
                  current_user_id: current_user.id,
                  current_user_username: current_user.username }
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
