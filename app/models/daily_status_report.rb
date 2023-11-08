class DailyStatusReport < ApplicationRecord
  belongs_to :project
  belongs_to :daily_status
  validates_presence_of :task, :description, :start_time, :end_time

  def total_time
    time = ""
    if start_time.present? && end_time.present?
      difference = Time.at(time_difference).utc
      hour = difference.strftime("%H")
      mint = difference.strftime("%M")
      if hour.to_i > 0
        time = "#{hour.to_i} Hr#{hour.to_i > 1 ? 's' : ''}"
      end
      if mint.to_i > 0
        time = "#{time ? time + " " : ""}#{mint} Mins"
      end
    end
    time
  end

  def time_difference
    if start_time.present? && end_time.present?
      (end_time_value - start_time_value)
    else
      0
    end
  end

  private

  def set_position_value
    self.position = 0
  end

  def start_time_value
    start_time.strftime("1970-01-01 %H:%M:%S UTC").to_time
  end

  def end_time_value
    value = end_time.strftime("1970-01-01 %H:%M:%S UTC").to_time
    value1 = end_time.strftime("1970-01-02 %H:%M:%S UTC").to_time
    start_time_value > value ? value1 : value
  end
end
