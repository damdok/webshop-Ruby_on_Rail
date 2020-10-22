module ApplicationHelper
  def categories_by_parent(parent)
    Category.where(:parent => parent)
  end
end
