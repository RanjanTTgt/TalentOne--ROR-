class CreateUsersProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :users_projects do |t|
      t.date :assigned_date, null: false, default: -> { 'CURRENT_DATE' }
      t.text :description

      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
      t.timestamps
    end
  end
end
