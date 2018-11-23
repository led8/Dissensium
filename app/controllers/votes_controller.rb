class VotesController < ApplicationController

  def create
    @vote = Vote.new(vote_params)
    @vote.solution = Solution.find(params[:solution_id])
    @vote.user = current_user

    if @vote.save
      redirect_to issue_path(@vote.solution[:issue_id])
    else
      redirect_to issue_path(@vote.solution[:issue_id])
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:rating)
  end
end
