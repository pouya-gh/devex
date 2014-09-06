class Post < ActiveRecord::Base
  belongs_to :admin
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  validates :digest, presence: true
  validates :admin_id, presence: true
  validates :tags, length: {maximum: 5}

  before_save :chomp_tags

  def subscribtion_needed?
    self.pro
  end

  def self.has_tag(tag)
    self.where("'#{tag}' = ANY (tags) AND published = true")
  end

  def self.search_query(query)
    self.where("(title) LIKE '%#{query}%' OR '#{query}' = ANY (tags) AND published = true")
  end

  def chomp_tags
    self.tags.size.times do |indx|
      self.tags[indx].gsub!(/^\s+/, "")
      self.tags[indx].gsub!(/\s+$/, "")
    end
  end
end
