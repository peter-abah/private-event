class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :invitations
  has_many :invited, through: :invitations, class_name: 'User', source: :invited
end
