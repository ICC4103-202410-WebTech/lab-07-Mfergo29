class User < ApplicationRecord
    has_many :posts
    validates :name, presence: { message: "El nombre no puede estar en blanco" }
    validates :email, presence: true, uniqueness: { message: "El correo electrónico debe ser único" }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Formato de correo electrónico inválido" }
    validates :password, presence: true, length: { minimum: 6, message: "La contraseña debe tener al menos 6 caracteres" }
  end