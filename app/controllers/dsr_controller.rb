class DsrController < ApplicationController
  skip_before_action :build_node, except: [:add_dsr, :send_dsr, :received_dsr]
  include DsrConcern
  helper "dsr"

  # add new dsr function which initialize object for dsr
  def add_dsr
    @dsr = current_user.daily_statuses.new
    @dsr.daily_status_reports.build
    @dsr.documents.build
    @assigned_projects = current_user.projects
  end

  # create  function which create new dsr
  def create_dsr
    @assigned_projects = current_user.projects
    @dsr = current_user.daily_statuses.new(dsr_params)
    if @dsr.save
      flash[:success] = "Dsr send successfully."
      redirect_to :send_dsr_dsr_index
    else
      broadcast_flash_message("error", "Dsr not create.")
    end
  end

  # get list of sending dsr's of current users
  def send_dsr
    dsrs = current_user.daily_statuses.order("created_at DESC")
    @pagy, @dsrs = pagy(dsrs, link_extra: 'data-remote="true" data-action="click->dsr#startLoader"')
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  # get list of received dsr's for current users
  def received_dsr
    dsrs = DailyStatus.includes(:daily_status_reports).received(current_user.id).order("created_at DESC")
    @pagy, @dsrs = pagy(dsrs, link_extra: 'data-remote="true" data-action="click->dsr#startLoader"')
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def fetch_received
    @dsr = DailyStatus.received(current_user.id).find(params[:id])
    respond_to do |format|
      format.html { render partial: "dsr/dsr_detail", locals: { dsr: @dsr, current_user: current_user }, layout: false }
      format.js { render layout: false }
    end
  end

  def fetch_send
    @dsr = current_user.daily_statuses.includes(:daily_status_reports).find(params[:id])
    respond_to do |format|
      format.html { render partial: "dsr/dsr_detail", locals: { dsr: @dsr, current_user: current_user }, layout: false }
      format.js { render layout: false }
    end
  end

  def comments
    @dsr = DailyStatus.received(current_user.id).or(current_user.daily_statuses).find(params[:id])
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def add_comment
    @dsr = DailyStatus.received(current_user.id).or(current_user.daily_statuses).find(params[:id])
    @comment = @dsr.comments.new(dsr_comment_params)
    if @dsr.save
      respond_to do |format|
        format.js { render layout: false }
      end
    else
      flash[:alert] = "Failed to add comment."
      render :add_dsr
    end
  end

end
