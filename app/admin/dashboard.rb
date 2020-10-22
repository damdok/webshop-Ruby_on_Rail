ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        (5).downto(1).each do |i|
          panel 'Ordered ' + i.to_s + ' day' + (i>1 ? 's' : '') + ' ago' do
            ul do
              Invoice.where(:delivered => false).where(:created_at => i.days.ago..(i-1).days.ago).map do |invoice|
                li link_to(invoice.city + ', ' + invoice.street + ', '  + invoice.address, admin_invoice_path(invoice))
              end
            end
          end
        end
      end

      column do
        panel "Statistics" do
          count = Order.all.map(&:quantity).inject(0, &:+)
          cprice = Order.all.map {|order| order.quantity * order.product.newprice}.inject(0, &:+).round(2)
          vprice = Order.all.map {|order| order.quantity * order.product.usdvendorprice}.inject(0, &:+).round(2)
          para 'Sold items: ' + count.to_s
          para 'Customer price: $ ' + cprice.to_s
          para 'Vendor price: $ ' + vprice.to_s
          para 'Revenue: $ ' + (cprice - vprice).round(2).to_s
        end

        panel "Monthly Revenue" do
          (12).downto(1).each do |i|
            revenue = 0
            Invoice.where(:created_at => i.months.ago..(i-1).months.ago).map do |invoice|
              revenue += invoice.orders.map {|order| order.quantity * order.product.newprice}.inject(0, &:+).round(2) - invoice.orders.map {|order| order.quantity * order.product.usdvendorprice}.inject(0, &:+).round(2)
            end
            para 'Revenue ' + i.to_s + ' month' + (i>1 ? 's' : '') + ' ago: ' + revenue.round(2).to_s
          end
        end
      end
    end

  end
end
