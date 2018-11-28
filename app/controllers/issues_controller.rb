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

  def start
    @issue = Issue.includes(solutions: :user).find(params[:id])
     ActionCable.server.broadcast("issue_#{params[:id]}", {
      action: "new_solution",
      new_solution_partial: ApplicationController.renderer.render(
        partial: "solutions/form",
        locals: { issue: @issue, solution: Solution.new }
      )
    })
    ActionCable.server.broadcast("issue_leader_#{params[:id]}", {
      action: "new_solution",
      new_solution_partial: ApplicationController.renderer.render(
        partial: "solutions/form",
        locals: { issue: @issue, solution: Solution.new, leader: true }
      )
    })
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :support)
  end
end
