class CreateNodes < ActiveRecord::Migration[7.0]
  def change
    create_table :nodes do |t|
      t.string  :name,          null: false, default: ""
      t.string  :controller,    null: false, default: ""
      t.string  :action,        null: false, default: ""
      t.string  :icon
      t.integer :position
      t.integer :parent_id

      t.timestamps
    end
  end
end
