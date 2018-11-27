class VotesController < ApplicationController

  def new
    @issue = Issue.includes(solutions: :user).find(params[:issue_id])

    solutions = @issue.solutions

    # TODO: keep only solutions that have enough votes

    ActionCable.server.broadcast("issue_#{params[:issue_id]}", {
      action: "new_votes",
      new_votes_partial: ApplicationController.renderer.render(
        partial: "votes/form",
        locals: { issue: @issue, solutions: solutions }
      )
    })
    ActionCable.server.broadcast("issue_leader_#{params[:issue_id]}", {
      action: "new_votes",
      new_votes_partial: ApplicationController.renderer.render(
        partial: "votes/form",
        locals: { issue: @issue, solutions: solutions, leader: true }
      )
    })
  end

  def create

    current_user.votes.create(votes_params)

    # ajax response with "thanks for your vote"

    # broadcast votes infos to leader


    # if @vote.save
    #   respond_to do |format|
    #     format.html { redirect_to issue_path(@solution.issue.id) }
    #     format.js
    #   end
    # else
    #   respond_to do |format|
    #     format.html { render "issues/show" }
    #     format.js
    #   end
    # end
  end

  private

  def votes_params
    params_to_return = []
    params.require(:votes).each do |_, vote_params|
      params_to_return << vote_params.permit(:solution_id, :rating)
    end
    params_to_return
  end
end
