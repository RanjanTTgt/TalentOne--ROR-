class ReportController < ApplicationController
  skip_before_action :build_node, except: [:add_report, :send_report, :received_report]

  def add_report
    @weekly_report = current_user.weekly_statuses.new
    @weekly_report.weekly_status_reports.build
    @assigned_projects = current_user.projects
  end

  def create_report
    @weekly_report = current_user.weekly_statuses.new(weekly_params)
    @assigned_projects = current_user.projects

    if @weekly_report.save
      flash[:success] = "Weekly report send successfully."
      redirect_to :send_report_report_index
    else
      broadcast_flash_message("error", "Dsr not create.")
      render :add_report
    end
  end

  def send_report
    weekly_reports = current_user.weekly_statuses.order("created_at DESC")
    @pagy, @weekly_reports = pagy(weekly_reports, link_extra: 'data-remote="true" data-action="click->report#startLoader"')
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def received_report
    weekly_reports = WeeklyStatus.includes(:weekly_status_reports).received(current_user.id).order("created_at DESC")
    @pagy, @weekly_reports = pagy(weekly_reports, link_extra: 'data-remote="true" data-action="click->report#startLoader"')
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def fetch_received
    @report = WeeklyStatus.find(params[:id])
    respond_to do |format|
      format.html { render partial: "report/report_detail", locals: { report: @report, current_user: current_user }, layout: false }
      format.js { render layout: false }
    end
  end

  def fetch_send
    @report = current_user.weekly_statuses.includes(:weekly_status_reports).find(params[:id])
    respond_to do |format|
      format.html { render partial: "report/report_detail", locals: { report: @report, current_user: current_user }, layout: false }
      format.js { render layout: false }
    end
  end

  private

  def weekly_params
    params.require(:weekly_report).permit(to_ids: [], cc_ids: [], weekly_status_reports_attributes: [:id, :description, :project_id])
  end

end
