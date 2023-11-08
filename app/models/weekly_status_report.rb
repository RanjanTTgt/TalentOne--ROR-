class WeeklyStatusReport < ApplicationRecord
  belongs_to :project
  belongs_to :weekly_status
  validates_presence_of :description
end
