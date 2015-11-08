class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :content, length: { maximum: 140, message: 'too long'}, presence: {message: "can't be blank"}
end
