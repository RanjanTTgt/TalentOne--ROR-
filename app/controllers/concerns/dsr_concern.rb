module DsrConcern
  extend ActiveSupport::Concern

  private

  def dsr_params
    data = params.require(:dsr).permit(to_ids: [], cc_ids: [], documents_attributes: [:file], daily_status_reports_attributes: [:_destroy, :project_id, :id, :task, :description, :start_time, :end_time])
    product_id = nil
    position = 0
    data[:to_ids] = data[:to_ids].map(&:to_i) rescue []
    data[:cc_ids] = data[:cc_ids].map(&:to_i) rescue []
    data[:daily_status_reports_attributes].each do |key, value|
      if value[:project_id]
        product_id = value[:project_id]
      else
        value[:project_id] = product_id
      end
      value[:position] = position
      position += 1
    end
    data
  end

  def dsr_comment_params
    data = params.require(:dsr_comment).permit(:comment)
    data[:user_id] = current_user.id
    data
  end

end
