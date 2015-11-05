class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments
	validates :password, confirmation: true
	validates_uniqueness_of :email
	validates_presence_of :fname, :lname, :email, :password
	validates :password, presence: true, on: :create
	validates :password_confirmation, presence: true, on: :create
end
