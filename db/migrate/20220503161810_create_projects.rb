class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name,          null: false
      t.date :start_date,      null: false, default: -> { 'CURRENT_DATE' }
      t.integer :status

      t.references :manager, index: true
      t.references :lead,    index: true
      t.references :client,  index: true
      t.timestamps
    end
  end
end
