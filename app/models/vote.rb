class Vote < ApplicationRecord
  belongs_to :solution
  belongs_to :user
  validates :rating, presence: true, inclusion: { in: [1, 2, 3, 4, 5] },
  allow_nil: false, uniqueness: {scope: :user_id}

end
