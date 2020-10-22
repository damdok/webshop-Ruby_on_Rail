class CategoryController < ApplicationController
  def category
    @cat = Category.where("regexp_replace(lower(name), '( )', '-') = ?", params['name']).first

    if @cat.present?
      if @cat.parent.nil?
        @products = Product.where(:category => @cat.children).paginate(:page => params[:page])
      else
        @products = Product.where(:category => @cat).paginate(:page => params[:page])
      end
    end
  end

  def product
    @product = Product.find_by_id(params[:id])

    @othersbought = [];

    Order.where(:product => @product).each do |order|
      @othersbought.concat order.invoice.products.where.not(:id => @product.id)
    end
    @othersbought = @othersbought.sample(5)

    @ratings = Rating.where(:product => @product)
  end

  def rating
    if current_user
      rating = Rating.new
      rating.note = params[:note]
      rating.rating = params[:rating]
      rating.user = current_user
      rating.product = Product.find_by_id(params[:id])
      rating.save!
    end

    redirect_to '/product/' + params[:id]
  end

  def compare
    if params[:first].present? && params[:second].present?
      @first = Product.find_by_id(params[:first])
      @second = Product.find_by_id(params[:second])
      @firstratings = Rating.where(:product => @first)
      @secondratings = Rating.where(:product => @second)
    end
  end

  def select
    @products = Hash.new
    Category.where.not(:parent_id => nil).each do |category|
      @products[category.name] = Product.where(:category => category).pluck(:name, :id)
    end
  end
end
