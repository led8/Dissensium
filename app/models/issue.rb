class Issue < ApplicationRecord
  belongs_to :user
  has_many :solutions

  validates :title, presence: true

  mount_uploader :support, PhotoUploader

  after_validation :generate_slug

  def owned_by?(user)
    self.user == user
  end

  def to_param
    self.slug
  end

  private

  def generate_slug
    self.slug = Digest::SHA1.hexdigest "#{id} #{title}"
  end


end
