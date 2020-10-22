class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id', :dependent => :delete_all
  has_many :products

  def url
    self.name.parameterize
  end
end
