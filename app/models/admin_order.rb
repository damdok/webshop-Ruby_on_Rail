class AdminOrder < ActiveRecord::Base
  belongs_to :admin_user
  belongs_to :product
end
