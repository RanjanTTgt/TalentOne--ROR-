class CreateJoinTableEmailTracksUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :email_tracks, :users do |t|
      # t.index [:email_track_id, :user_id]
      # t.index [:user_id, :email_track_id]
    end
  end
end
