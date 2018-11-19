class Issue < ApplicationRecord
  belongs_to :user
  has_many :solutions

  validates :title, presence: true
end
