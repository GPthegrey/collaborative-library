class Event < ApplicationRecord
  belongs_to :organizer, class_name: 'User'
  has_many :assistances
end
