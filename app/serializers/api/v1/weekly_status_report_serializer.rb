class Api::V1::WeeklyStatusReportSerializer < Api::V1::BaseSerializer
  attributes :id, :project_name, :project_id, :description

  def project_name
    object.project.name rescue "N/A"
  end
end