class Event < ApplicationRecord
  belongs_to :organizer, class_name: 'User'
  has_many :assistances

  validates :title, :description, :start_date, :end_date, :address, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "Tiene que ser posterior a la fecha y hora de inicio")
    end
  end
end
