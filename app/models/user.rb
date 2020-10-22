class User < ActiveRecord::Base
  has_many :invoices
  has_many :carts, :dependent => :delete_all
  has_many :products, through: :carts
  has_many :ratings, :dependent => :delete_all

  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      if !user.name.present?
        user.name = auth_hash['info']['name']
      end
      user.image_url = auth_hash['info']['image']
      user.save!
      user
    end
  end

  def cartitemcount
    self.carts.map(&:quantity).inject(0, &:+)
  end

  def cartprice
    if regular
      ((carts.map {|cart| cart.quantity * cart.product.newprice}.inject(0, &:+)) * 0.95).round(2)
    else
      carts.map {|cart| cart.quantity * cart.product.newprice}.inject(0, &:+).round(2)
    end
  end

  def discountcartprice
    (cartprice * 0.95).round(2)
  end

  def filledprofile
    name.present? && email.present? && phone.present? && city.present? && street.present? && address.present?
  end
end
