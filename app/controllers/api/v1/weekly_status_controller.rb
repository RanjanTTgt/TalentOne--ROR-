class Api::V1::WeeklyStatusController < Api::V1::BaseController

  def add_report
    weekly_status_reports = current_user.weekly_statuses.create!(weekly_status_params)
    render_serialize_data(serializer: serializer,
                          obj: weekly_status_reports,
                          message: 'Weekly Status Send Successfully',
                          paginate: true)
  end

  def send_list
    weekly_status_reports = current_user.weekly_statuses.order("created_at DESC")
    render_serialize_data(serializer: serializer,
                          obj: weekly_status_reports,
                          message: 'Weekly Status Report List Fetched Successfully',
                          paginate: true)
  end

  def received_list
    weekly_status_reports = WeeklyStatus.includes(:weekly_status_reports).received(current_user.id).order("created_at DESC")
    render_serialize_data(serializer: serializer,
                          obj: weekly_status_reports,
                          message: 'Weekly Status Report List Fetched Successfully',
                          paginate: true)
  end

  def fetch_send
    daily_status_report = current_user.weekly_statuses.includes(:weekly_status_reports).find(params[:id])
    render_serialize_data(serializer: serializer,
                          options: {show_detail: true},
                          obj: daily_status_report,
                          message: 'Weekly Status Report Detail Fetched Successfully',
                          paginate: true)
  end

  def fetch_received
    daily_status_report = WeeklyStatus.received(current_user.id).find(params[:id])
    render_serialize_data(serializer: serializer,
                          options: {show_detail: true},
                          obj: daily_status_report,
                          message: 'Weekly Status Report Detail Fetched Successfully',
                          paginate: true)
  end

  private

  def serializer
    Api::V1::WeeklyStatusSerializer
  end

  def weekly_status_params
    params.permit(to_ids: [], cc_ids: [], weekly_status_reports_attributes: [:_destroy, :id, :description, :project_id])
  end

end
