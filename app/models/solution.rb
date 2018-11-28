class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :issue
  has_many :votes, inverse_of: :solution

  validates :content, presence: true

  def from?(some_user)
    user == some_user
  end

  def bobby
    unless self.votes.count.zero?

      list_votes = votes.map { |vote| vote[:rating] }

      grouped_votes = []
      grouped_votes.push(list_votes.count(5)).push(list_votes.count(4)).push(list_votes.count(3)).push(list_votes.count(2)).push(list_votes.count(1))

      sum = 0
      sum_of_votes = grouped_votes.map { |x| sum += x }

      majority_vote = sum_of_votes.map { |x| x >= grouped_votes.sum.to_f / 2 }

      majority_vote_index = majority_vote.index(true)

      if majority_vote_index.zero?
        return " Excellent"
      elsif majority_vote_index == 1
        return " Très bien"
      elsif majority_vote_index == 2
        return " Bien"
      elsif majority_vote_index == 3
        return " Passable"
      else
        return " Insuffisant"
      end
    end
  end

  def solution_average_rating
    self.votes.average(:rating) * 20 unless self.votes.average(:rating).nil?
  end
end
