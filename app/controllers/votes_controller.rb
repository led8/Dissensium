class VotesController < ApplicationController

  def create
    @vote = Vote.new(vote_params)
    @vote.solution = Solution.find(params[:solution_id])
    @vote.user = current_user
    @vote.save

    if @vote.save
      # redirect_to new_issue_path(@issue)
    else
      render 'issues/new'
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:rating)
  end
end
