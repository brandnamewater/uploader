class Order < ApplicationRecord

  mount_uploader :video, VideoUploader
  serialize :video, JSON # If you use SQLite, add this line.

  # def set_success(format, opts)
  #   self.success = true
  # end
  #validates_presence_of :video



  #validates :address, :city, :state, presence: true
  def order_sales_relationship
    Order.where(id: SalesUpload.where(:order_id))
  end


  belongs_to :listing
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
#  belongs_to :buyer
  #has_one :sales_upload
  #has_one :sales_upload, :as => :video
  #has_many :sales_uploads

end
