class User < ApplicationRecord
	has_secure_password
	validates :e_mail, presence: true, uniqueness: true
end
