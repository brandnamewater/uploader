class OrderMailer < ApplicationMailer
  default from: 'from@example.com'

  def order_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Sample Email')
  end


end
