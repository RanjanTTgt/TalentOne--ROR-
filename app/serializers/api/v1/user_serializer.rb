class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id, :first_name, :last_name, :email, :dob, :role, :reporting_manager_id
end
