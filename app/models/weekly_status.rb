class WeeklyStatus < StatusReport
  belongs_to :user
  has_many :weekly_status_reports, dependent: :destroy
  accepts_nested_attributes_for :weekly_status_reports, allow_destroy: true
end