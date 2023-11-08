class CreateAttendanceReports < ActiveRecord::Migration[7.0]
  def change
    create_table :attendance_reports do |t|
      t.date        :date,     default: -> { 'CURRENT_DATE' }
      t.datetime    :time_in
      t.datetime    :time_out
      t.integer     :status, null: false

      t.references     :user, index: true
      t.timestamps
    end
  end
end
