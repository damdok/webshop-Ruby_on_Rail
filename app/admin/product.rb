ActiveAdmin.register Product do
  permit_params :category_id, :vendor_id, :price, :discount, :name, :stock, :description, :wholesale_price, :image_url, :image

  filter :category
  filter :users, label: 'In cart of'
  filter :vendor
  filter :price
  filter :discount
  filter :name
  filter :stock
  filter :description
  filter :wholesale_price
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :name
    column :category
    column :stock
    column :price
    column :discount
    column :wholesale_price
    column :vendor
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :price
      row :discount
      row :name
      row :stock
      row :description
      row :wholesale_price
      row :category
      row :vendor
      row :created_at
      row :updated_at
      row :image do
        image_tag product.image_url
      end
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :category
      f.input :vendor
      f.input :price
      f.input :discount
      f.input :name
      f.input :stock
      f.input :description
      f.input :wholesale_price
      f.input :image, as: :file
    end
    f.actions
  end

  controller do
    def create
      @product = Product.new
      @product[:category_id] = permitted_params[:product][:category_id]
      @product[:vendor_id] = permitted_params[:product][:vendor_id]
      @product[:price] = permitted_params[:product][:price]
      @product[:discount] = permitted_params[:product][:discount]
      @product[:name] = permitted_params[:product][:name]
      @product[:stock] = permitted_params[:product][:stock]
      @product[:description] = permitted_params[:product][:description]
      @product[:wholesale_price] = permitted_params[:product][:wholesale_price]
      @product[:created_at] = Time.now
      @product[:updated_at] = Time.now

      @product.save
      @product = Product.last

      filename = @product.id.to_s + File.extname(permitted_params[:product][:image].original_filename)

      @product[:image_url] = Settings::ROOT + 'products/' + filename

      File.open(Rails.root.join('public', 'products', filename), 'wb') do |file|
        file.write(permitted_params[:product][:image].read)
      end

      if @product.save
        redirect_to admin_product_path(@product)
      else
        render :new
      end
    end

    def update
      @product = Product.where(id: permitted_params[:id]).first!
      @product[:category_id] = permitted_params[:product][:category_id]
      @product[:vendor_id] = permitted_params[:product][:vendor_id]
      @product[:price] = permitted_params[:product][:price]
      @product[:discount] = permitted_params[:product][:discount]
      @product[:name] = permitted_params[:product][:name]
      @product[:stock] = permitted_params[:product][:stock]
      @product[:description] = permitted_params[:product][:description]
      @product[:wholesale_price] = permitted_params[:product][:wholesale_price]
      @product[:updated_at] = Time.now

          filename = permitted_params[:id] + File.extname(permitted_params[:product][:image].original_filename)
      @product[:image_url] = Settings::ROOT + 'products/' + filename

      File.open(Rails.root.join('public', 'products', filename), 'wb') do |file|
        file.write(permitted_params[:product][:image].read)
      end

      if @product.save
        redirect_to admin_product_path(@product)
      else
        render :edit
      end
    end
  end
end
