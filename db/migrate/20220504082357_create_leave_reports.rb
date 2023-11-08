class CreateLeaveReports < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_reports do |t|
      t.date            :date,                null: false, default: -> { 'CURRENT_DATE' }
      t.integer         :status,              default: false
      t.string          :subject,             null: false
      t.text            :reason,              null: false
      t.text            :rejected_reason,     null: false

      t.references     :user, index: true
      t.timestamps
    end
  end
end
