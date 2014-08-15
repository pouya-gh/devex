class Post < ActiveRecord::Base
  attr_accessor :tags
  belongs_to :admin, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  validates :digest, presence: true
  validates :admin_id, presence: true
  validate :tags_cant_be_more_than_5

  private
  def tags_cant_be_more_than_5
    if tags && (tags.size > 5)
      errors.add(:tags, "In valid number of tags")
    end
  end
end
