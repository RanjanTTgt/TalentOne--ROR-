class DailyStatus < StatusReport
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :daily_status_reports, dependent: :destroy
  accepts_nested_attributes_for :daily_status_reports, allow_destroy: true
  has_many :documents, as: :documentable
  accepts_nested_attributes_for :documents,:reject_if => lambda { |a| a[:file].blank? }
end