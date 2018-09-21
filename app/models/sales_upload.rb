class SalesUpload < ApplicationRecord


  mount_uploader :video, VideoUploader
  serialize :video, JSON # If you use SQLite, add this line.

  #validates :address, :city, :state, presence: true

  belongs_to :order
  belongs_to :user





end
