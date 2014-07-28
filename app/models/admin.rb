# encoding: utf-8

class Admin < ActiveRecord::Base
	has_secure_password

  has_many :posts

  require "sign_in_tools"
  include SignInTools
  after_save :regenerate_auth_token

  validates :first_name, presence: true, length: { minimum: 3, maximum: 30 },
            format: { with: VALID_NAME_REGEX }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 30 },
            format: { with: VALID_NAME_REGEX }
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  def last_posts
    self.posts.last(5).reverse
  end

  def admin?
  	true
  end
end
