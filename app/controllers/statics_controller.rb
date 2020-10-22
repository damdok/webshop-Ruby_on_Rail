include PayPal::SDK::REST
include PayPal::SDK::Core::Logging

class StaticsController < ApplicationController
  def index
    @newproducts = []
    Category.where(:parent_id => nil).each do |cat|
      product = Product.where(:category => cat.children).order(created_at: :desc).first
      if product.present?
        @newproducts << product
      end
    end
  end

  def user
    if request.patch?
      current_user.name = params['user']['name']
      current_user.email = params['user']['email']
      current_user.phone = params['user']['phone']
      current_user.city = params['user']['city']
      current_user.street = params['user']['street']
      current_user.address = params['user']['address']
      if current_user.save
        flash[:success] = 'Successfully updated your profile!'
      else
        flash[:warning] = 'An error occured!'
      end
    end
  end

  def balance
    PayPal::SDK::REST.set_config(
        :mode => PayPal::SDK.configure.mode,
        :client_id => PayPal::SDK.configure.client_id,
        :client_secret => PayPal::SDK.configure.client_secret)

    @payment = Payment.new({
       :intent =>  "sale",
       :payer =>  {
           :payment_method =>  "paypal" },
       :redirect_urls => {
           :return_url => request.base_url + "/user/balance/execute/?cancel=false",
           :cancel_url => request.base_url + "/user/balance/execute/?cancel=true" },
       :transactions =>  [{
          :item_list => {
              :items => [{
                 :name => "Credit",
                 :sku => "pieces",
                 :price => "0.01",
                 :currency => "USD",
                 :quantity => params['user']['credit'] }]},
          :amount =>  {
              :total =>  view_context.number_with_precision(0.01 * params['user']['credit'].to_f, :precision => 2),
              :currency =>  "USD" },
          :description =>  "Credits at RailsWebshop." }]})


    if @payment.create
      redirect_to @payment.links.find{|v| v.method == "REDIRECT" }.href
    else
      logger.error @payment.error.inspect
      flash[:warning] = 'There was an error during the payment!'
      redirect_to '/user'
    end
  end

  def execute
    if params['cancel'] == 'true'
      flash[:warning] = 'The payment is canceled!'
      redirect_to '/user'
    else
      if Payment.find(params['paymentId']).execute( :payer_id => params['PayerID'] )
        current_user.balance += Payment.find(params['paymentId']).transactions[0].item_list.items[0].quantity.to_i
        current_user.save
        flash[:success] = 'The payment was successful!'
        Mailer.paypal_email(current_user).deliver_now
        redirect_to '/user'
      else
        flash[:warning] = 'There was an error during the payment!'
        redirect_to '/user'
      end
    end
  end

  def cart
    if current_user
      @carts = current_user.carts

      @youshouldbuy = []

      categories = []
      current_user.invoices.each do |invoice|
        invoice.orders.each do |order|
          categories << order.product.category
        end
      end

      @youshouldbuy = Product.where(:category => categories).sample(2)

    end
  end

  def popular
    @popularproducts = []
    Category.where(:parent_id => nil).each do |cat|
      max = 0
      popular = nil
      Product.where(:category => cat.children).each do |product|
        current = product.orders.sum('quantity')
        if current > max
          max = current
          popular = product
        end
      end

      if popular.present?
        @popularproducts << popular
      end
    end
  end
end
