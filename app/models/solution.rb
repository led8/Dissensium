class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :issue
  has_many :votes

  validates :content, presence: true

  after_create :broadcast_solution

  def from?(some_user)
    user == some_user
  end

  def broadcast_solution
    ActionCable.server.broadcast("issue_#{issue.id}", {
      solution_partial: ApplicationController.renderer.render(
        partial: "solutions/solution",
        locals: { solution: self, vote: Vote.new, user_is_solutions_author: false }
      ),
      current_user_id: user.id
    })
  end

  def bobby
    unless self.votes.count.zero?
      byebug
      grouped_votes = []
      grouped_votes.push(self.votes.count(5)).push(self.votes.count(4)).push(self.votes.count(3)).push(self.votes.count(2)).push(self.votes.count(1))

      sum = 0
      sum_of_votes = grouped_votes.map { |x| sum += x }

      majority_vote = sum_of_votes.map { |x| x >= grouped_votes.sum.to_f / 2 }

      majority_vote_index = majority_vote.index(true)

      if majority_vote_index.zero?
        return " insuffisant"
      elsif majority_vote_index == 1
        return " passable"
      elsif majority_vote_index == 2
        return " bien"
      elsif majority_vote_index == 3
        return " très bien"
      else
        return "excellent"
      end
    end
  end

  def solution_average_rating
    self.votes.average(:rating) * 20 unless self.votes.average(:rating).nil?
  end
end
