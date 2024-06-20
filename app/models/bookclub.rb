class Bookclub < ApplicationRecord
  belongs_to :organizer, class_name: 'User', foreign_key: 'organizer_id'

  validates :name, presence: true
  validates :description, presence: true
  validates :organizer_id, presence: true
  validates :location, presence: true
  validates :max_members, presence: true
  validates :privacy, presence: true
  validates :genre, presence: true
  validates :meeting_schedule, presence: true
end
