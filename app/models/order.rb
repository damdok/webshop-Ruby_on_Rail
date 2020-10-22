class Order < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :product
  has_one :user, through: :invoice
end
