class VotesController < ApplicationController

  def create
    @vote = Vote.new(vote_params)
    @vote.solution = Solution.find(params[:solution_id])
    @vote.user = current_user

    if @vote.save
     respond_to do |format|
        format.html { redirect_to issue_path(@solution.issue.id) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "issues/show" }
        format.js
      end
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:rating)
  end
end
