class Api::V1::ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :status, :manager_id, :lead_id, :client_id
end
