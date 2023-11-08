class DashboardController < ApplicationController

  def index
    @total_assigned_projects = current_user.projects.count
    @total_dsr_send = current_user.daily_statuses.count
    @total_dsr_received = DailyStatus.received(current_user.id).count
    @upcoming_birthdays = User.upcoming_birthdays
    @attendance = current_user.start_working
  end
end
