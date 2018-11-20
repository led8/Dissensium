class SolutionsController < ApplicationController

  def create
    @solution = Solution.new(solution_params)
    @solution.issue = Issue.find(params[:issue_id])
    @solution.user = current_user

    if @solution.save
      redirect_to issue_path(@solution[:issue_id])
    else
      render 'issues/new'
    end
  end

  private

  def solution_params
    params.require(:solution).permit(:content)
  end
end