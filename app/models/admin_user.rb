class AdminUser < ActiveRecord::Base
  has_many :admin_orders
  has_many :products, through: :admin_orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  def display_name
    self.email
  end
end
