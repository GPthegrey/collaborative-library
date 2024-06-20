class Review < ApplicationRecord
  belongs_to :user_reviewed, class_name: 'User'
  belongs_to :user_reviewer, class_name: 'User'
  belongs_to :loan
end
