class Invoice < ActiveRecord::Base
  belongs_to :user
  belongs_to :courier
  has_many :orders, :dependent => :delete_all
  has_many :products, through: :orders

  self.per_page = 10
end
