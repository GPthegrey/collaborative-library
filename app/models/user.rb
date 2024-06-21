class User < ApplicationRecord
  after_create :send_welcome_email
  has_many :books
  has_many :loans_as_borrower, class_name: 'Loan', foreign_key: :borrower_id
  has_many :loans_as_owner, class_name: 'Loan', foreign_key: :owner_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def send_welcome_email
    UserMailer.hello(self).deliver_now
  end

end
