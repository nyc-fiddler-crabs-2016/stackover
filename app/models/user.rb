class User < ActiveRecord::Base
  has_secure_password
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy

end
