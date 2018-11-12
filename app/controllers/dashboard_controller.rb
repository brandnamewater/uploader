class DashboardController < ApplicationController

  def dashboard
    @orders = Order.all.where(seller: current_user).paginate(:page => params[:page], :per_page => 15) || @orders = Order.all.where(seller: current_buyer).paginate(:page => params[:page], :per_page => 15)
    #@sales_upload = SalesUpload.new(params[:video])
    #@listing = Listing.find(params[:listing_id])
    @orders_a = Order.all.where(seller: current_user) || @orders = Order.all.where(seller: current_buyer)
    @orders_b = Order.all.where(seller: current_user).where("created_at <> updated_at") || @orders = Order.all.where(seller: current_buyer)

    @orders_month = @orders_a.all.group_by { |mon|  mon.created_at.beginning_of_month }
    @orders_day = @orders_a.all.group_by { |day|  day.created_at.beginning_of_day }



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

    @orders = orders.paginate(:page => params[:all_orders_page], :per_page => 15)
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
