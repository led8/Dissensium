class Vote < ApplicationRecord
  belongs_to :solution, inverse_of: :votes
  belongs_to :user
  validates :rating, presence: true, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :solution_id, uniqueness: {scope: :user_id}

  after_create :broadcast_vote

  def broadcast_vote
    ActionCable.server.broadcast("issue_#{solution.issue.id}", {
      vote_partial: ApplicationController.renderer.render(
        partial: "votes/vote",
        locals: { solution: self.solution },
      ),
      current_user_id: user.id,
      solution: self.solution.id
    })
  end

end
