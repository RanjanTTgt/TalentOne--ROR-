class Api::V1::DashboardController < Api::V1::BaseController

  def index
    total_assigned_projects = current_user.projects.count
    total_dsr_send = current_user.daily_statuses.count
    total_dsr_received = DailyStatus.received(current_user.id).count
    upcoming_birthdays = User.upcoming_birthdays
    attendance = current_user.start_working

    render_success(message: "Data fetched successfully", data: {
      total_assigned_projects: total_assigned_projects,
      total_dsr_received: total_dsr_received,
      total_dsr_send: total_dsr_send,
      upcoming_birthdays: ActiveModelSerializers::SerializableResource.new(upcoming_birthdays, each_serializer: Api::V1::UserSerializer),
      attendance: attendance && ActiveModelSerializers::SerializableResource.new(attendance, serializer: Api::V1::AttendanceSerializer)
    })
  end

end
