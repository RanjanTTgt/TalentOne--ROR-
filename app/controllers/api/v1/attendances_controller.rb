class Api::V1::AttendancesController < Api::V1::BaseController

  def index
    if params[:start_date].present? && params[:end_date].present?
      attendance_reports = current_user.attendance_reports.where(date: (params[:start_date].to_date)..(params[:end_date].to_date))
    else
      attendance_reports = current_user.attendance_reports
    end

    render_serialize_data(serializer: Api::V1::AttendanceSerializer,
                          obj: attendance_reports.order("date DESC"),
                          message: 'Attendance Data Fetched Successfully',
                          paginate: true)
  end

  def time_in
    attendance = current_user.start_working
    if attendance.present?
      attendance.time_in = Time.now unless attendance.time_in.present?
      attendance.save
    else
      attendance = current_user.attendance_reports.create(time_in: Time.now)
    end
    render_serialize_data(serializer: Api::V1::AttendanceSerializer,
                          obj: attendance,
                          message: 'Logged in Successfully')

  end

  def time_out
    attendance = current_user.start_working
    return render_error(message: "Please login first.") unless attendance.present?
    today_dsr = current_user.daily_statuses.today
    weekly_report = Time.zone.now.friday? ? current_user.weekly_statuses.today : today_dsr
    return render_error(message: "Please send DSR first.") unless today_dsr.present?
    return render_error(message: "Please send Weekly Report first.") unless weekly_report.present?
    attendance.time_out ||= Time.now
    unless attendance.save
      return render_error(message: "Something went wrong.") unless weekly_report.present?
    end
    render_serialize_data(serializer: Api::V1::AttendanceSerializer,
                          obj: attendance,
                          message: 'Logged out Successfully')

  end

end
