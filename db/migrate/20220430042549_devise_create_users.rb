# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string    :first_name,         null: false, default: ""
      t.string    :last_name,          default: ""
      t.string    :email,              null: false, default: ""
      t.string    :encrypted_password, null: false, default: ""
      t.date      :dob
      t.date      :joining_date,       default: -> { 'CURRENT_DATE' }

      t.integer   :role
      t.integer   :status
      t.string    :employee_code, null: false, default: ""
      t.string    :phone_number, null: false, default: ""
      t.string    :mobile_number, null: false, default: ""
      t.string    :address, null: false, default: ""
      t.string    :permanent_address, null: false, default: ""
      t.string    :pan_number, null: false, default: ""
      t.string    :reporting_manager_id
      t.string    :reporting_manager_id2
      t.integer   :permission_id
      t.integer   :is_admin
      t.string    :profile_picture

      ## References
      t.references   :department
      t.references   :designation

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps null: false
    end

    add_index :users, :email,                   unique: true
    add_index :users, :reset_password_token,    unique: true
    # add_index :users, :confirmation_token,      unique: true
    # add_index :users, :unlock_token,            unique: true
  end
end
