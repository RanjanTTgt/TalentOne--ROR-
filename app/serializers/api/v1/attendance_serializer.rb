class Api::V1::AttendanceSerializer < Api::V1::BaseSerializer
  attributes :date, :time_in, :time_out, :status, :user_id
end
