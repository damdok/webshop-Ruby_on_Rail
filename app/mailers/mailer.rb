class Mailer < ApplicationMailer
  default :from => %("RubyWebshop" <noreply@rubywebshop.com>)

  def invoice_email(user, invoice_path)
    @user = user
    @invoice_path = invoice_path
    @url = Settings::ROOT
    mail( :to => %("#{@user.name}" <#{@user.email}>), :subject => 'New invoice' )
  end

  def paypal_email(user)
    @user = user
    @url = Settings::ROOT
    mail( :to => %("#{@user.name}" <#{@user.email}>), :subject => 'Successful purchase' )
  end
end
