class Issue < ApplicationRecord
  belongs_to :user
  has_many :solutions

  validates :title, presence: true

  mount_uploader :support, PhotoUploader

  def owned_by?(user)
    self.user == user
  end
# To generate a random link
  # def to_param
  #   Digest::SHA1.hexdigest "#{id} #{title}"
  # end
end
