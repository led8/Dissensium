class IssuesController < ApplicationController

  def show
    @issue = Issue.includes(solutions: :user).find(params[:id])
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

  def update
    @issue = Issue.includes(solutions: :user).find(params[:id])
    titre = { title: @issue.title }
    @issue.update(titre)
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :support)
  end
end
