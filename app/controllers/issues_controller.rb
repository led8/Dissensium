class IssuesController < ApplicationController

  def show
    @issue = Issue.find(params[:id])
    @solution = Solution.new
    @vote = Vote.new
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.user = current_user
    @issue.save

    if @issue.save
      redirect_to new_issue_path(@issue)
    else
      render :new
    end
  end

  def results
    # @solutions.issue = Solution.where(@votes.solution >= 2)
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :support)
  end
end
