class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :content, length: { maximum: 140, message: 'too long' }, presence: { message: "can't be blank" }
  validates :user_id, presence: true

  default_scope -> { order(created_at: :desc) }
end
