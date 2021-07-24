class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: 'User'
  belongs_to :invited, class_name: 'User'
  belongs_to :event

  enum status: {
    attending: 1
    not_attending: 0
  }
  
end
