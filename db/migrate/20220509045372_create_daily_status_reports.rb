class CreateDailyStatusReports < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_status_reports do |t|
      t.string     :task,            null: true
      t.text       :description,     null: false
      t.integer    :position
      t.time       :start_time
      t.time       :end_time

      t.references :project,           index: true
      t.references :daily_status,     index: true
      t.timestamps
    end
  end
end
