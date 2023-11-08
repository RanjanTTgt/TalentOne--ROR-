class CreateLeaveTimings < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_timings do |t|
      t.date            :date,              null: false
      t.integer         :leave_type
      t.integer         :slot

      t.references    :leave_report,  index: true
      t.timestamps
    end
  end
end
