class EmployeesController < ApplicationController

  # list of employees
  def index
    users = User.all.order("created_at DESC")
    @pagy, @users = pagy(users, link_extra: 'data-remote="true" data-action="click->attendance#startLoader"')

    respond_to do |format|
      format.html
      format.js {render layout: false}
    end

  end
end
