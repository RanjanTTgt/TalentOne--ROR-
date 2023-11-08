namespace :user_attendances do
  desc "Create Absent Record"
  task create_record: :environment do
    User.active.each do |user|
      user.attendance_reports.create unless user.start_working.present?
    end
  end

  desc "Mark Present Record"
  task mark_present: :environment do
    AttendanceReport.today_attendances.is_working.update_all(status: "is_present")
  end
end
