class Post < ActiveRecord::Base
  belongs_to :admin
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  validates :digest, presence: true
  validates :admin_id, presence: true
  validates :tags, length: {maximum: 5}

  def subscribtion_needed?
    self.pro
  end

  def self.has_tag(tag)
    self.where("'#{tag}' = ANY (tags) AND published = true")
  end
end
