class Document < ApplicationRecord
  mount_uploader :file, FileUploader
  belongs_to :documentable, polymorphic: true

  validates_presence_of :file
  validates_integrity_of :file
end
