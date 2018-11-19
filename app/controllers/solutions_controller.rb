class SolutionsController < ApplicationController

  def new
    @solution = Solution.new
  end

  def create
    @solution = Solution.new(solution_params)
    @solution.save

    if @solution.save
      redirect_to new_issue_path(@issue)
    else
      render :new
    end
  end

  private

  def solution_params
    params.require(:solution).permit(:content)
  end
end
