class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user! || before_action :authenticate_buyer
  before_action :deny_to_visitors

  def order_and_sales_upload
    #Order.where(:id).joins(:sales_upload).where("sales_upload.sorder_id = ?")

    if Order.where(id: Sales_upload.pluck(:order_id)) == true
    end


end


  def sales
    @orders = Order.all.where(seller: current_user) || @orders = Order.all.where(seller: current_buyer)
    #@sales_upload = SalesUpload.new(params[:video])
    #@listing = Listing.find(params[:listing_id])

    #@sales_upload = SalesUpload.new(sales_upload_params)
    #@sales_upload = SalesUpload.new

    #@order = Order.find(params[:orders_id])]
    #@order = Order.find(params[:order_id])
    #@sales_upload.user_id = current_user.id
    @order = Order.new

  end

  def purchases
    @orders = Order.all.where(buyer: current_user || current_buyer) #|| @orders = Order.all.where(buyer: current_buyer)
  #  @orders = Order.all.where(buyer: current_buyer)
  end






  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
    #@order = Order.find(params[:order_id])

  end

  # GET /orders/1/edit
  def edit
  end


  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @listing = Listing.find(params[:listing_id])
    @seller = @listing.user

    @order.listing_id = @listing.id
    @order.buyer_id = current_user.id
    #@order.buyer_id = current_buyer.id
    #@order.buyer_id = (current_buyer.id || current_user.id)
    @order.seller_id = @seller.id




    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        if user_signed_in?
        format.html { redirect_to @order, notice: 'Shout was successfully uploaded.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
      if buyer_signed_in?
      format.html { redirect_to @order, notice: 'Order was successfully updated.' }
      format.json { render :show, status: :ok, location: @order }
    else
      format.html { render :edit }
      format.json { render json: @order.errors, status: :unprocessable_entity }
    end
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :city, :state, :image, :video)
    end

    def deny_to_visitors
      redirect_to root_path unless user_signed_in? or buyer_signed_in?
    end

    def user_orders
      @order.buyer_id = current_buyer.id or current_user
    end

end
