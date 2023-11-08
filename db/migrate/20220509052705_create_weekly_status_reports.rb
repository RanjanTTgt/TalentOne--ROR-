class CreateWeeklyStatusReports < ActiveRecord::Migration[7.0]
  def change
    create_table :weekly_status_reports do |t|
      t.text       :description,     null: false
      t.integer    :position

      t.references :project,           index: true
      t.references :weekly_status,     index: true
      t.timestamps
    end
  end
end
