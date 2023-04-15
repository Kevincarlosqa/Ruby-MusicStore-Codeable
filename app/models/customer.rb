class Customer < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true,  format: { with: URI::MailTo::EMAIL_REGEXP, message: 'El formato de correo electrónico no es válido' }
  validates :password, length: { minimum: 6 }, format: { with: /\d/ }
end
