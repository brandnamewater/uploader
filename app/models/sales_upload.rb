class SalesUpload < ApplicationRecord

  mount_uploader :video, VideoUploader
  serialize :video, JSON # If you use SQLite, add this line.


  #belongs_to :listing
  #belongs_to :user_id
  #belongs_to :seller, class_name: "User"
#  belongs_to :buyer

  #belongs_to :order
  #belongs_to :buyer, class_name: "User"

  belongs_to :user
  has_many :listings

  has_many :orders
  has_many :buyers

end
