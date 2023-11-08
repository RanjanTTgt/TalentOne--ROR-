class Api::V1::DailyStatusSerializer < Api::V1::BaseSerializer
  attributes :id, :title, :user_name, :date, :user_id, :user_email
  attribute :project_name, unless: :eligible_for_detail
  has_many :daily_status_reports, serializer: Api::V1::DailyStatusReportSerializer, if: :eligible_for_detail
  has_many :to_details, if: :eligible_for_detail
  has_many :cc_details, if: :eligible_for_detail

  def title
    daily_status_report.description.to_s.squish.truncate_bytes(50) rescue "-"
  end

  def project_name
    daily_status_report.project.name rescue "N/A"
  end

  def daily_status_report
    object.daily_status_reports.first
  end

  def eligible_for_detail
    options[:show_detail] rescue false
  end

  def to_details
    ((object.to_ids && User.where(id: object.to_ids).pluck(:email).join(", ")) || "N/A") rescue "N/A"
  end

  def cc_details
    ((object.cc_ids && User.where(id: object.cc_ids).pluck(:email).join(", ")) || "N/A") rescue "N/A"
  end

  def user_name
    object.user.full_name
  end

  def user_email
    object.user.email
  end
end
