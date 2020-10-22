class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :vendor
  has_many :orders
  has_many :invoices, through: :orders
  has_many :carts, :dependent => :delete_all
  has_many :users, through: :carts
  has_many :admin_orders
  has_many :admin_users, through: :admin_orders
  has_many :ratings, :dependent => :delete_all

  self.per_page = 5

  def newprice
    (self.usdprice * (1- self.discount)).round(2)
  end

  def regularprice
    (newprice * 0.95).round(2)
  end

  def discountprice
    (newprice * 0.95).round(2)
  end

  def discountandregularprice
    ((newprice * 0.95) * 0.95).round(2)
  end

  def usdprice
    # prices in the DB are currently in HUF
    (self.price / 270.0).round(2)
  end

  def usdvendorprice
    # prices in the DB are currently in HUF
    (self.wholesale_price / 270.0).round(2)
  end

  def notreviewed(user)
    ratings.where(:user => user).length == 0
  end
end
