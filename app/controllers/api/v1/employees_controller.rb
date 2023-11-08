class Api::V1::EmployeesController < Api::V1::BaseController

  def get_all_user
    @users = User.all.active.where.not(id: current_user.id)
    render_serialize_data(serializer: serializer,
                          options: { show_detail: true },
                          obj: @users,
                          message: 'Employee List Fetched Successfully',
                          paginate: true)
  end



  private

  def serializer
    Api::V1::EmployeeSerializer
  end

end
