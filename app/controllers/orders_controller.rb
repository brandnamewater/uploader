class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user! || before_action :authenticate_buyer
  before_action :deny_to_visitors

  #def sales
  #  @orders = Order.all.where(seller: current_user) || @orders = Order.all.where(seller: current_buyer)
    #@sales_upload = SalesUpload.new(params[:video])

#    @sales_upload = SalesUpload.new(params[:video])
#    @sales_upload.user_id = current_user.id

  #  @sales_upload.name =  @sales_upload.image.file.filename if @sales_upload.name == ""

#    respond_to do |format|
#      if @sales_upload.save
#        format.html { redirect_to @sales_upload, notice: 'Photo was successfully created.' }
#        format.json { render action: 'show', status: :created, location: @sales_upload }
#      else
#        format.html { render action: 'new' }
#        format.json { render json: @sales_upload.errors, status: :unprocessable_entity }
#      end
#    end
  #end

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

    #before_action :user_orders



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
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
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
      params.require(:order).permit(:address, :city, :state, :image, :video)
    end

    def deny_to_visitors
      redirect_to root_path unless user_signed_in? or buyer_signed_in?
    end

    def user_orders
      @order.buyer_id = current_buyer.id or current_user
    end

end
