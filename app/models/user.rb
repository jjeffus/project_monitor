class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :name, type: String, default: ""
  field :email, type: String, default: ""
  field :password, type: String, default: ""
  field :password_confirmation, type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :remember_me, type: Boolean, default: false
end