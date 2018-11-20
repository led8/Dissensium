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

    if @issue.save
      redirect_to issue_path(@issue)
    else
      render :new
    end
  end

  def results

  end

  private

  def issue_params
    params.require(:issue).permit(:title)
  end
end
