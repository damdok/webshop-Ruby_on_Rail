class Courier < ActiveRecord::Base
  has_many :invoices
end
