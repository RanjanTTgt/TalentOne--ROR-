class Project < ApplicationRecord
  has_many :users_projects
  has_many :users, through: :users_projects
  belongs_to :client, optional: true
  enum status: %i[active hold completed], _default: "active"

end
