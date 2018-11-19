class DashboardController < ApplicationController

  def account

    @balance = Stripe::Balance.retrieve(
      {:stripe_account => current_user.stripe_token}
    )

    # @payout = Stripe::Payout.retrieve(
    #   {:stripe_account => current_user.stripe_token}
    # )

    @transaction = Stripe::BalanceTransaction.all(
      {
        :limit => 10,
        type: 'payment',
        available_on: { gt: Time.now.tomorrow.to_i },
      },
        { stripe_account: current_user.stripe_token }
    )



    @transfer = Stripe::Transfer.list(
      {
        limit: 100
      },
      {stripe_account: current_user.stripe_token}
    )


    @payments = Stripe::Charge.list(
      {
        limit: 100, # The number of charges to retrieve (between 1 and 100)
        expand: ['data.source_transfer', 'data.application_fee'] # Expand other objects for additional detail
      },
      { stripe_account: current_user.stripe_token } # The Stripe ID of the user viewing the dashboard
    )


    @payouts = Stripe::Payout.list(
      {
        limit: 100,
        expand: ['data.destination'] # Get some extra detail about the bank account
      },
      { stripe_account: current_user.stripe_token } # Again, authenticating with the ID of the connected account
    )



  end

  def payout_destination

    @txns = Stripe::BalanceTransaction.list(
      {
        payout: params[:id], # The ID of the payout you want transactions for
        expand: ['data.source.source_transfer'], # Expand the source_transfer for extra detail
        limit: 100
      },
      { stripe_account: current_user.stripe_token }
    )

  end


  def settings
    @user = current_user.id
    @stripe_account = StripeAccount.find_by(params[:aa])
  end


  def dashboard
    # @orders = Order.all.where(seller: current_user).paginate(:page => params[:page], :per_page => 15) || @orders = Order.all.where(seller: current_buyer).paginate(:page => params[:page], :per_page => 15)
    #@sales_upload = SalesUpload.new(params[:video])
    #@listing = Listing.find(params[:listing_id])
    @orders_a = Order.all.where(seller: current_user).paginate(:page => params[:month_orders_page], :per_page => 12)
    @orders_b = Order.all.where(seller: current_user).paginate(:page => params[:day_orders_page], :per_page => 7)

    @orders_c = Order.all.where(seller: current_user).where("created_at < updated_at").paginate(:page => params[:month_orders_page_1], :per_page => 12)
    @orders_d = Order.all.where(seller: current_user).where("created_at < updated_at").paginate(:page => params[:day_orders_page_1], :per_page => 7)


    @orders_month = @orders_a.all.group_by { |mon|  mon.created_at.beginning_of_month }
    @orders_day = @orders_b.all.group_by { |day|  day.created_at.beginning_of_day }


    #@sales_upload = SalesUpload.new(sales_upload_params)
    #@sales_upload = SalesUpload.new

    #@order = Order.find(params[:orders_id])]
    #@order = Order.find(params[:order_id])
    #@sales_upload.user_id = current_user.id
    @order = Order.new

  end

  def tables

    user = current_user || current_buyer
    orders = Order.where(seller: user)
    orders_with_video = Order.find_by(video: present?)

    @orders_tables = orders.paginate(:page => params[:all_orders_page], :per_page => 15)
    @orders_tables_comp = Order.all.where(:order_status == 2).paginate(:page => params[:comp_orders_page], :per_page => 15)
    @orders_tables_up = Order.all.where(:order_status == 1).paginate(:page => params[:up_orders_page], :per_page => 15)
    # @orders_tables_present = Order.all.where(orders_with_video).paginate(:page => params[:present_order_page], :per_page => 15)

    # @orders_for_card = orders.paginate(:page => params[:whatever_orders_page], :per_page => 7)
    # @orders_by_month = orders.group_by { |mon| mon.created_at.beginning_of_month }
    # @orders_with_video = orders_with_video && orders_with_video.paginate(:page => params[:completed_orders_page], :per_page => 7)



    # @orders = Order.all.where(seller: current_user).paginate(:page => params[:page], :per_page => 15) || @orders = Order.all.where(seller: current_buyer).paginate(:page => params[:page], :per_page => 15)
    # @orders_pag_7 = Order.all.where(seller: current_user).paginate(:page => params[:page_7], :per_page => 7) || @orders = Order.all.where(seller: current_buyer).paginate(:page => params[:page_7], :per_page => 7)
    #
    # @orders_pag_7_1 = Order.where(video: present?).paginate(:page => params[:page_7_1], :per_page => 7)
    # @orders_month = @orders.group_by { |mon| mon.created_at.beginning_of_month }
    # @orders_b = Order.all.where(seller: current_user).find_by(:video.present?).paginate(:page => params[:page], :per_page => 7)


  end

  def charts
    @orders = Order.all.where(seller: current_user).paginate(:page => params[:page], :per_page => 15) || @orders = Order.all.where(seller: current_buyer).paginate(:page => params[:page], :per_page => 15)
    @orders_month = @orders.group_by { |mon| mon.created_at.beginning_of_month }



  end


end
