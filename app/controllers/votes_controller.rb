class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.save

    if @vote.save
      redirect_to new_issue_path(@issue)
    else
      render :new
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:rating)
  end
end
