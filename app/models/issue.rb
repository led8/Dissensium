class Issue < ApplicationRecord
  belongs_to :user
  has_many :solutions

  validates :title, presence: true

  mount_uploader :support, PhotoUploader

  after_update :broadcast_starting_meeting

  def broadcast_starting_meeting
    ActionCable.server.broadcast("issue_#{self.id}", {
      message: "starting_meeting",
      current_user_id: user.id
    })
  end

# To generate a random link
  # def to_param
  #   Digest::SHA1.hexdigest "#{id} #{title}"
  # end
end
