# encoding: utf-8

class User < ActiveRecord::Base
  has_secure_password

  # first and last name should contain only numbers and letters and whitespaces
  VALID_NAME_REGEX = /\A[A-Za-zا-ی0-9۰-۹\s]+\z/
  validates :first_name, presence: true, length: { minimum: 3, maximum: 30 },
            format: { with: VALID_NAME_REGEX }

  validates :last_name, presence: true, length: { minimum: 3, maximum: 30 },
            format: { with: VALID_NAME_REGEX }

  VALID_EMAIL_REGEX = /\A([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})\z/
  validates :email, format: { with: VALID_EMAIL_REGEX }
end
