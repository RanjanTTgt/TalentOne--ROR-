class CreateEmailTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :email_tracks do |t|
      t.string      :subject,       null: false
      t.text        :content,       null: false
      t.text        :to_user,       null: false
      t.text        :cc_user,       null: false

      t.references  :email_trackable, polymorphic: true

      t.timestamps
    end
  end
end
