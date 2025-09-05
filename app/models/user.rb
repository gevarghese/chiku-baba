# app/models/user.rb
class User < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Define roles as an enum
   enum :role, { user: 0, admin: 1, moderator: 2 }, default: :user
  
  
  # Devise modules (customize as needed)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable
  
  # Validations
  validates :first_name, :last_name, presence: true
  validates :role, presence: true
  
  # Set default role
  after_initialize :set_default_role, if: :new_record?
  
  def full_name
    "#{first_name} #{last_name}".strip
  end
  
  private
  
  def set_default_role
    self.role ||= :user
  end
end
