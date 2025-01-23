class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[user admin]
  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'admin'
  end
  
  def user?
    role == 'user'
  end
end
