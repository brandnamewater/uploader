class Order < ApplicationRecord

  mount_uploader :video, VideoUploader
  serialize :video, JSON # If you use SQLite, add this line.

  #validates :address, :city, :state, presence: true

  belongs_to :listing
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
#  belongs_to :buyer
  #has_one :sales_upload
  has_one :sales_upload, :as => :video


end
