class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :phone_number, length: {is: 9}, presence: true, uniqueness: true, numericality: {only_integer: true}
  validates :organization, presence: true, length: {minimum: 3}

end
