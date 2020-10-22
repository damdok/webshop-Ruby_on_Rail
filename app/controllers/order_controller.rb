class OrderController < ApplicationController
  def addtocart
    if current_user
      prod = Product.find_by_id(params['id'])
      if prod.present?
        cart = Cart.find_or_create_by(user: current_user, product: prod)
        cart.quantity += 1
        cart.save
      end
    end
    render :nothing => true
  end

  def removefromcart
    if current_user
      prod = Product.find_by_id(params['id'])
      if prod.present?
        cart = Cart.find_by(user: current_user, product: prod)
        if cart.quantity == 1
          cart.destroy
        else
          cart.quantity -= 1
          cart.save
        end
      end
    end
    render :nothing => true
  end

  def order
    if current_user
      discount = current_user.cartprice > 500

      if (discount ? current_user.discountcartprice : current_user.cartprice) * 100  < current_user.balance
        invoice = Invoice.new
        invoice.delivered = false
        invoice.city = current_user.city
        invoice.street = current_user.street
        invoice.address = current_user.address
        invoice.total = (discount ? current_user.discountcartprice : current_user.cartprice)
        invoice.user = current_user
        invoice.save

        pay = Payday::Invoice.new(:invoice_number => invoice.id)
        pay.bill_to = current_user.name
        pay.due_at = Time.now.strftime("%Y-%m-%d")
        pay.paid_at = Time.now.strftime("%Y-%m-%d")
        pay.tax_rate = 0
        pay.notes = 'Contact: ' + current_user.phone + ',  ' + current_user.email
        pay.ship_to = current_user.city + ', ' + current_user.street + ' ' + current_user.address

        orders = []
        current_user.carts.each do |cart|
          order = Order.new
          order.invoice = invoice
          order.product = cart.product
          order.quantity = cart.quantity
          cart.product.stock -= cart.quantity
          cart.product.save
          orders << order

          price = 0
          if current_user.regular
            if discount
              price = cart.product.discountandregularprice
            else
              price = cart.product.regularprice
            end
          else
            if discount
              price = cart.product.discountprice
            else
              price = cart.product.newprice
            end
          end

          pay.line_items << Payday::LineItem.new(:price => price, :quantity => cart.quantity, :description => cart.product.name)
        end
        invoice.orders = orders

        pay.render_pdf_to_file(Rails.root.join('public', 'invoices', invoice.id.to_s + ".pdf"))
        invoice.pdf = request.base_url + '/invoices/' + invoice.id.to_s + ".pdf"

        invoice.save
        current_user.balance -= ((discount ? current_user.discountcartprice : current_user.cartprice) * 100).to_i
        current_user.carts.destroy_all

        if current_user.invoices.sum(:total) > 1000
          current_user.regular = true
        end

        current_user.save

        Mailer.invoice_email(current_user, invoice.pdf).deliver_now
      else
        raise 'Not enough credits'
      end
    end
    render :nothing => true
  end

  def previous
    if current_user
      @invoices = current_user.invoices.order("id desc").paginate(:page => params[:page])
    end
  end

  def products
    if current_user
      @products = []
      current_user.invoices.each do |invoice|
        @products.concat invoice.products
      end
      @products = @products.uniq
    end
  end
end
