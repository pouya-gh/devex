class Post < ActiveRecord::Base
  belongs_to :admin, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  validates :digest, presence: true
  validates :admin_id, presence: true
end
