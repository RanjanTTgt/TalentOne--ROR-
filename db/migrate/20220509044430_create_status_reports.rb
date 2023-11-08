class CreateStatusReports < ActiveRecord::Migration[7.0]
  def change
    create_table :status_reports do |t|
      t.date     :date,             null: false, default: -> { 'CURRENT_DATE' }
      t.string   :to_ids,           null: false, index: true
      t.string   :cc_ids,           index: true
      t.string   :type,             null: false, index: true, default: "DailyStatus"
      t.integer  :status,           null: false
      t.references :user,     index: true

      t.timestamps
    end
  end
end
