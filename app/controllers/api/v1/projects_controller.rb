class Api::V1::ProjectsController < Api::V1::BaseController


  def assigned_projects
    projects = current_user.projects
    render_serialize_data(serializer: serializer,
                          obj: projects.order(name: :asc),
                          message: 'Project Data Fetched Successfully',
                          paginate: false)

  end


  def serializer
    Api::V1::ProjectSerializer
  end

end
