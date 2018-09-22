class SalesUploadsController < ApplicationController
  before_action :set_sales_upload, only: [:show, :edit, :update, :destroy]


  def sales
    @orders = Order.all.where(seller: current_user) || @orders = Order.all.where(seller: current_buyer)
    #@sales_upload = SalesUpload.new(params[:video])
    #@sales_upload = SalesUpload.new(sales_upload_params)
    @sales_upload = SalesUpload.new
    #@order = Order.find(params[:orders_id])]
    #@order = Order.find(params[:order_id])
    @sales_upload.user_id = current_user.id

  end


  # GET /sales_uploads
  # GET /sales_uploads.jsonra
  def index
    @sales_uploads = SalesUpload.all
  end

  # GET /sales_uploads/1
  # GET /sales_uploads/1.json
  def show
  end

  # GET /sales_uploads/new
  def new
    @sales_upload = SalesUpload.new
    @order = Order.find(params[:order_id])

  end

  # GET /sales_uploads/1/edit
  def edit
  end

  # POST /sales_uploads
  # POST /sales_uploads.json
  def create
    @sales_upload = SalesUpload.new(sales_upload_params)
    @sales_upload.user_id = current_user.id

    #@order = Order.find(params[:order_id])


    respond_to do |format|
      if @sales_upload.save
        format.html { redirect_to @sales_upload, notice: 'Shout upload was successfully created.' }
        format.json { render :show, status: :created, location: @sales_upload }
      else
        format.html { render :new }
        format.json { render json: @sales_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_uploads/1
  # PATCH/PUT /sales_uploads/1.json
  def update
    respond_to do |format|
      if @sales_upload.update(sales_upload_params)
        format.html { redirect_to @sales_upload, notice: 'Sales upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @sales_upload }
      else
        format.html { render :edit }
        format.json { render json: @sales_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_uploads/1
  # DELETE /sales_uploads/1.json
  def destroy
    @sales_upload.destroy
    respond_to do |format|
      format.html { redirect_to sales_uploads_url, notice: 'Sales upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_upload
      @sales_upload = SalesUpload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_upload_params
      params.require(:sales_upload).permit(:video)
    end
end
