class SolutionsController < ApplicationController
  after_action :broadcast_solution, only: [:create]

  def create
    @solution = Solution.new(solution_params)
    @solution.issue = Issue.find(params[:issue_id])
    @solution.user = current_user

    if @solution.save
      broadcast_solution_create(@solution)
      respond_to do |format|
        format.html { redirect_to issue_path(@issue) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "issues/show" }
        format.js
      end
    end
  end

  def broadcast_solution
    ActionCable.server.broadcast("issue_#{@solution.issue.id}", {
      action: "solutions",
      solution_partial: ApplicationController.renderer.render(
        partial: "solutions/solution",
        locals: { solution: @solution }
      ),
      current_user_id: @solution.user.id
    })

    ActionCable.server.broadcast("issue_leader_#{@solution.issue.id}", {
      action: "solutions",
      solution_partial: ApplicationController.renderer.render(
        partial: "solutions/solution",
        locals: { solution: @solution, leader: true }
      ),
      current_user_id: @solution.user.id
    })
  end

  private

  def broadcast_solution_create(solution)
    ActionCable.server.broadcast("issue_#{solution.issue.id}", {
      current_user_id: current_user.id,
      action: "create_solution",
      solution_hint: " is ready" })
    ActionCable.server.broadcast("issue_leader_#{solution.issue.id}", {
      current_user_id: current_user.id,
      action: "create_solution",
      solution_hint: " is ready" })
  end

  def solution_params
    params.require(:solution).permit(:content)
  end
end
