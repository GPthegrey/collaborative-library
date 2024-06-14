class User < ApplicationRecord
  has_many :books
  has_many :loans_as_borrower, class_name: 'Loan', foreign_key: :borrower_id
  has_many :loans_as_owner, class_name: 'Loan', foreign_key: :owner_id

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
