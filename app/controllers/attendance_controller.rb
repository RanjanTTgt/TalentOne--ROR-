class AttendanceController < ApplicationController
  skip_before_action :build_node, except: [:user_attendance_list, :today_attendance_list]

  # show all attendance lists of current users
  def user_attendance_list
    if params[:start_date].present? && params[:end_date].present?
      attendance_reports = current_user.attendance_reports.where(date: (params[:start_date].to_date)..(params[:end_date].to_date))
    else
      attendance_reports = current_user.attendance_reports
    end
    @pagy, @attendance_reports = pagy(attendance_reports.order("date DESC"), link_extra: 'data-remote="true" data-action="click->attendance#startLoader"')

    respond_to do |format|
      format.html
      format.js { render layout: false }
      format.xls do
        task = Spreadsheet::Workbook.new
        sheet = task.create_worksheet
        format = Spreadsheet::Format.new(size: 11, name: "calibri")
        attendance_reports.order("date ASC").all.each.with_index(1) do |attendance, i|
          sheet.row(i).concat [attendance.date&.strftime('%d-%m-%Y') || "-",
                               attendance.time_in&.strftime('%d-%m-%Y %I:%M %p') || "-",
                               attendance.time_out&.strftime('%d-%m-%Y %I:%M %p') || "-",
                               attendance.working_time,
                               attendance.status_name]
          sheet.row(i).default_format = format
        end
        sheet.row(0).concat ["Date", "Time In", "Time Out", "Total Working Time", "Status"]
        sheet.column(0).width = 15
        sheet.column(1).width = 20
        sheet.column(2).width = 20
        sheet.column(3).width = 20
        sheet.column(4).width = 10
        sheet.row(0).each.with_index { |c, i| sheet.row(0).set_format(i, format) }
        temp_file = StringIO.new
        task.write(temp_file)
        file_name = [current_user.first_name]
        file_name << "attendance"
        file_name << params[:start_date].to_date.strftime("%d_%B") if params[:start_date].present?
        file_name << params[:end_date].to_date.strftime("%d_%B") if params[:end_date].present?
        file_name = file_name.compact.join("_").gsub(" ", "")
        send_data(temp_file.string, filename: "#{file_name}.xls", disposition: 'inline')
      end
    end
  end

  # list of all users today's lists
  def today_attendance_list
    if current_user.employee?
      redirect_to root_path
    end

    attendance_reports = AttendanceReport.today_attendances
    @pagy, @attendance_reports = pagy(attendance_reports.order("date DESC"), link_extra: 'data-remote="true" data-action="click->attendance#startLoader"')

    respond_to do |format|
      format.html
      format.js { render layout: false }
    end

  end

  # time in using post method
  def time_in
    @attendance = current_user.start_working
    if @attendance.present?
      @attendance.time_in = Time.now unless @attendance.time_in.present?
      @attendance.save
    else
      @attendance = current_user.attendance_reports.create(time_in: Time.now)
    end
  end

  # time out using post method
  def time_out
    attendance = current_user.start_working
    return broadcast_flash_message("warning", "Please login first.") unless attendance.present?
    today_dsr = current_user.daily_statuses.today
    weekly_report = Time.zone.now.friday? ? current_user.weekly_statuses.today : today_dsr
    return broadcast_flash_message("warning", "Please send DSR first.") unless today_dsr.present?
    return broadcast_flash_message("warning", "Please send Weekly Report first.") unless weekly_report.present?
    attendance.time_out ||= Time.now
    unless attendance.save
      broadcast_flash_message("error", "Something went wrong.")
    end
  end

end
