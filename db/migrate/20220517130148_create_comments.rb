class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :comment

      t.references :user, index: true
      t.references :commentable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
