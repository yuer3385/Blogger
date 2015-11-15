class User < ActiveRecord::Base
  has_many :microposts

  validates :name, presence: {message: "can't be blank"}
  validates :email, presence: {message: "can't be blank"}
end