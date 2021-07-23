class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :invitations
  has_many :invited, through: :invitations, class_name: 'User', source: :invited

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :date, presence: true

  def attendees
    invitations.where(accepted: true).includes(:invited).map(&:invited)
  end
end
