class BankAccountsController < ApplicationController
  before_action :authenticate_user!

  def new
    # Redirect if no stripe account exists yet
    unless current_user.stripe_token
      redirect_to new_user_stripe_account_path and return
    end

    begin
      # Retrieve the account object for this user
      @stripe_account = Stripe::Account.retrieve(current_user.stripe_token)
      # @stripe_account = Stripe::Account.retrieve(@stripe_account.acct_id)


    # Handle exceptions from Stripe
    rescue Stripe::StripeError => e
      handle_error(e.message, 'new')

    # Handle any other exceptions
    rescue => e
      flash[:error] = e.message
    end
  end

  def create
    # Redirect if no token is POSTed or the user doesn't have a Stripe account
    unless params[:stripeToken] && current_user.stripe_token
      redirect_to new_bank_account_path and return
    end

    begin
      # Retrieve the account object for this user
      # Stripe.api_key = "sk_test_5RwdUKMOUYo1TQnbDAgPy0QG"

      stripe_account = Stripe::Account.retrieve(current_user.stripe_token)
      stripe_account.external_accounts.create(external_account:{
        :source => {
          :object => "bank_account",
          # :account_number => bank_account_number,
          :country => country,
          :currency => "USD",
          :account_holder_name => account_holder_name,
          :account_holder_type => account_holder_type,
          :routing_number => routing_number
          }
        })


      # Create the bank account
      stripe_account.external_account = params[:stripeToken]
      stripe_account.save

      # Success, send on to the dashboard
      flash[:success] = "Your bank account has been added!"
      redirect_to dashboard_path

    # Handle exceptions from Stripe
    rescue Stripe::StripeError => e
      # handler_for_rescue(e.message, 'new')
      flash[:error] = e.message


    # Handle any other exceptions
    rescue => e
      # handle_error(e.message, 'new')
      flash[:error] = e.message
    end
  end
end
