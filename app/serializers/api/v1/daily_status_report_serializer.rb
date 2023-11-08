class Api::V1::DailyStatusReportSerializer < Api::V1::BaseSerializer
  attributes :id, :task, :project_name, :project_id, :start_time, :end_time, :description, :total_time

  def project_name
    object.project.name rescue "N/A"
  end
end