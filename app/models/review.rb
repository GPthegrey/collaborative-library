class Review < ApplicationRecord
  belongs_to :user_reviewed
  belongs_to :user_reviewer
  belongs_to :loan
end
