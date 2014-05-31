# encoding: utf-8

class User < ActiveRecord::Base
  has_secure_password

  has_many :posts

  after_save :regenerate_auth_token

  # first and last name should contain only numbers and letters and whitespaces
  VALID_NAME_REGEX = /\A[A-Za-zا-ی0-9۰-۹\s]+\z/
  validates :first_name, presence: true, length: { minimum: 3, maximum: 30 },
            format: { with: VALID_NAME_REGEX }

  validates :last_name, presence: true, length: { minimum: 3, maximum: 30 },
            format: { with: VALID_NAME_REGEX }

  VALID_EMAIL_REGEX = /\A([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})\z/
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  def regenerate_auth_token
    update_columns(auth_token: generate_token)
  end

  # def token_for(field)
  #   write_attribute(field.to_sym, generate_token)
  # end
  def days_left
    (subscribed_until - Date.today).to_i unless !subscribed_until
  end

  def last_posts
    self.posts.last(5).reverse
  end

  def generate_token
    salt = 'asdwrewqsafaaewvkmnp(872134n1231%^23123basdklm)(u89u123$234alklkmasfbb*^T^t213'
    text = salt + Time.now.to_s + email.to_s
    Digest::MD5.hexdigest(text)
  end
end
