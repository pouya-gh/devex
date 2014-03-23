class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  validates :digest, presence: true
end
