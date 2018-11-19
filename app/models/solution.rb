class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :issue
  has_many :votes

  validates :content, presence: true
end
