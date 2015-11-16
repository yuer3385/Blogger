class User < ActiveRecord::Base
  has_many :microposts

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: { message: "can't be blank" }, length: { maximum: 50 }
  validates :email, presence: { message: "can't be blank" }, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  has_secure_password

  before_save :format_email_to_downcase


  def format_email_to_downcase
    self.email = email.downcase
  end
end