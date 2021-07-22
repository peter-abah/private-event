class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :sent_invites, class_name: 'Invitation', foreign_key: :inviter_id
  has_many :received_invites, class_name: 'Invitation', foreign_key: :invited_id
  has_many :invited_events, through: :received_invites, class_name: 'Event', source: :event,
            foreign_key: :invited_id

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def attended_events
    received_invites.where(accepted: true).pluck(:event)
  end
end
