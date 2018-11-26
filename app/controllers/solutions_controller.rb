class SolutionsController < ApplicationController

  def create
    @solution = Solution.new(solution_params)
    @solution.issue = Issue.find(params[:issue_id])
    @solution.user = current_user

    if @solution.save
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

  private

  def solution_params
    params.require(:solution).permit(:content)
  end
end
