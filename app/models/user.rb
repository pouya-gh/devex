# encoding: utf-8

class User < ActiveRecord::Base
  has_secure_password

  # first and last name should contain only numbers and letters and whitespaces
  VALID_NAME_REGEX = /\A[A-Za-zا-ی0-9۰-۹\s]+\z/
  validates :first_name, presence: true, length: { minimum: 3, maximum: 30 },
            format: { with: VALID_NAME_REGEX }

  validates :last_name, presence: true, length: { minimum: 3, maximum: 30 },
            format: { with: VALID_NAME_REGEX }
end
