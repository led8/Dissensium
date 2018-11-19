class IssuesController < ApplicationController

  def show
    @issue = Issue.find(params[:id])
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.save

    if @issue.save
      redirect_to new_issue_path(@issue)
    else
      render :new
    end
  end

  def results
    @solutions.issue = Solution.where(@votes.issue >= 2)
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :support)
  end
end
