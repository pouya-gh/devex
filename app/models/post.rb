class Post < ActiveRecord::Base
  belongs_to :admin
  validates :title, presence: true
  validates :body, presence: true
  validates :digest, presence: true
end
