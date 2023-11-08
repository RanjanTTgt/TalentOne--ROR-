class Api::V1::DailyStatusController < Api::V1::BaseController

  def add_dsr
    daily_status_reports = current_user.daily_statuses.create!(dsr_params)
    render_serialize_data(serializer: serializer,
                          obj: daily_status_reports,
                          message: 'Daily Status Send Successfully',
                          paginate: true)
  end

  def send_list
    daily_status_reports = current_user.daily_statuses.order("created_at DESC")
    render_serialize_data(serializer: serializer,
                          obj: daily_status_reports,
                          message: 'Daily Status Report List Fetched Successfully',
                          paginate: true)
  end

  def received_list
    daily_status_reports = DailyStatus.includes(:daily_status_reports).received(current_user.id).order("created_at DESC")
    render_serialize_data(serializer: serializer,
                          obj: daily_status_reports,
                          message: 'Daily Status Report List Fetched Successfully',
                          paginate: true)
  end

  def fetch_send
    daily_status_report = current_user.daily_statuses.includes(:daily_status_reports).find(params[:id])
    render_serialize_data(serializer: serializer,
                          options: {show_detail: true},
                          obj: daily_status_report,
                          message: 'Daily Status Report Detail Fetched Successfully',
                          paginate: true)
  end

  def fetch_received
    daily_status_report = DailyStatus.received(current_user.id).find(params[:id])
    render_serialize_data(serializer: serializer,
                          options: {show_detail: true},
                          obj: daily_status_report,
                          message: 'Daily Status Report Detail Fetched Successfully',
                          paginate: true)

  end

  def add_comment
    daily_status_report = DailyStatus.received(current_user.id).or(current_user.daily_statuses.daily).find(params[:id])
    comment = daily_status_report.comments.new(dsr_comment_params)
    comment.save!
  end

  private

  def serializer
    Api::V1::DailyStatusSerializer
  end


  def dsr_params
    data = params.permit(to_ids: [], cc_ids: [], attachments: [], daily_status_reports_attributes: [:_destroy, :project_id, :id, :task, :description, :start_time, :end_time])
    project_id = nil
    position = 0
    data[:to_ids] = data[:to_ids].map(&:to_i) rescue []
    data[:cc_ids] = data[:cc_ids].map(&:to_i) rescue []
    data[:daily_status_reports_attributes].each do |key, value|
      if value[:project_id]
        project_id = value[:project_id]
      else
        value[:project_id] = project_id
      end
      value[:position] = position
      position += 1
    end
    data
  end

  def dsr_comment_params
    data = params.permit(:comment)
    data[:user_id] = current_user.id
    data
  end


end
