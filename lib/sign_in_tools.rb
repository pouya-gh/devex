# encoding: utf-8

module SignInTools  
  # first and last name should contain only numbers and letters and whitespaces
  VALID_NAME_REGEX = /\A[A-Za-zا-ی0-9۰-۹\s]+\z/
  VALID_EMAIL_REGEX = /\A([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})\z/

  def regenerate_auth_token
    update_columns(auth_token: generate_token)
  end

  def generate_token
    salt = 'asdwrewqsafaaewvkmnp(872134n1231%^23123basdklm)(u89u123$234alklkmasfbb*^T^t213'
    text = salt + Time.now.to_s + email.to_s
    Digest::MD5.hexdigest(text)
  end
end