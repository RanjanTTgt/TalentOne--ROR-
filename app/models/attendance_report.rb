class AttendanceReport < ApplicationRecord
  has_paper_trail
  STATUS_NAMES = HashWithIndifferentAccess.new({ is_working: "Working", is_absent: "Absent", is_present: "Present", on_leave: "Leave" })

  belongs_to :user
  enum status: %i[is_absent is_working is_present on_leave], _default: "is_absent"
  validate :validate_status_value, if: :time_out_changed?
  before_save :validate_values
  scope :today_attendances, -> { where("DATE(date) = ?", Date.today) }

  def working_time
    return "-" unless time_out.present?
    Time.at(time_out - time_in).utc.strftime("%H:%M:%S")
  end

  def status_name
    STATUS_NAMES[status]
  end

  after_save_commit :broadcast_attendance_data

  private

  def validate_status_value
    if self.status && self.status_was == "is_present"
    #   self.errors.add(:status, "can be changed is after submit.")
    end
  end

  def validate_values
    self.status = 'is_working' if self.time_in_was.present? || self.time_in.present?
    self.status = 'is_present' if self.time_out_was.present? || self.time_out.present?
  end

  # broadcast attendance data (Realtime update on browser withour page refresh)
  def broadcast_attendance_data
    broadcast_replace_to "user-attendance-#{user_id}",
                         target: "user-attendance-#{user_id}",
                         partial: "attendance/attendance",
                         locals: {attendance: self, user_id: self.user_id}
    broadcast_replace_to "user-attendance-record",
                         target: "user-attendance-record-#{encrypted_id}",
                         partial: "attendance/attendance_record",
                         locals: {attendance: self}
  end

end
