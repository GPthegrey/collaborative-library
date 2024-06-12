class Book < ApplicationRecord
  belongs_to :user, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_by_title_and_author,
  against: [ :title, :author ],
  using: {
    tsearch: { prefix: true }
  }

  scope :by_genre, ->(genre) { where(genre: genre) }
  scope :by_language, ->(language) { where(language: language) }

end
