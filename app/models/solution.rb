class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :issue
  has_many :votes

  validates :content, presence: true

  after_create :broadcast_solution
  after_update :broadcast_starting_meeting

  def from?(some_user)
    user == some_user
  end

  def broadcast_solution
    ActionCable.server.broadcast("issue_#{issue.id}", {
      solution_partial: ApplicationController.renderer.render(
        partial: "solutions/solution",
        locals: { solution: self, user_is_solutions_author: false }
      ),
      current_user_id: user.id
    })
  end

  def broadcast_starting_meeting
    ActionCable.server.broadcast("issue_#{issue.id}", {
      # message: "c'est partiiiiiiiiiii",
      current_user_id: user.id
    })
  end

  def solution_average_rating
    self.votes.average(:rating) * 20 unless self.votes.average(:rating).nil?
  end
end
