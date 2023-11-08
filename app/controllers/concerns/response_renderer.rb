module ResponseRenderer

  extend ActiveSupport::Concern

  # Handle 422 errors with custom JSON response
  def render_unprocessable_entity(exception)
    @errors = exception.record.errors.map do |x|
      attribute = x.attribute.to_s.split('.')
      if attribute.length > 1
        model_name = attribute[0].singularize.camelcase
        model_name = Module.constants.include?(model_name.to_sym) ? model_name : "User"
        { field: x.attribute.to_s.split('.')[-1],
          message: "#{(model_name.constantize).human_attribute_name(attribute[-1])} #{x.message}" }
      else
        { field: x.attribute.to_s,
          message: x.full_message }
      end
    end
    render json: { success: false, message: exception.message, errors: @errors, status_code: 422 }, status: 422
  end

  # Handle 404 errors with custom JSON response
  def render_not_found(exception)
    @errors = [{ field: "#{exception.model.downcase}_#{exception.primary_key}", message: exception.message }]
    render json: { success: false, message: exception.message, errors: @errors, status_code: 404 }, status: 404
  end

  # Handle 500 errors with custom JSON response
  def render_not_unique_response(exception)
    render json: { success: false, message: exception.message, errors: [], status_code: 500 }, status: 500
  end

  # Handle JWT token exceptions with custom JSON response
  def jwt_invalid_token
    render json: { success: false, message: "Invalid token", status_code: 401 }, status: 401
  end

  def jwt_verification_error
    render json: { success: false, message: "Invalid token", status_code: 401 }, status: 401
  end

  def render_invalid_token(exception)
    render json: { success: false, message: exception.message, status_code: 401 }, status: 401
  end

  def render_not_authorized_response
    render json: { success: false, message: "You are not authorized to perform this action." }, status: :forbidden
  end

  ##########
  # Other error Response
  ##########

  # Common method to render error response inside this module
  def render_error(message: nil, errors: [], status_code: 400)
    render json: { success: false, message: message, error: errors, status_code: status_code }, status: status_code
  end

  # Handle Rails exceptions with custom JSON response
  def render_500_error(message: "internal server error")
    render json: { success: false, message: message, status_code: 500 }, status: 500
  end

  # Handle 401 errors with custom JSON response
  def render_unauthorized(message: nil, errors: [])
    render json: { success: false, message: message, errors: errors, status_code: 401 }, status: 401
  end

  # Handle 403 errors with custom JSON response
  def render_forbidden(message: nil)
    render json: { success: false, message: message, status_code: 403 }, status: 403
  end

  ##########
  # Sucesss Response
  ##########

  # Common method to render success response
  def render_success(message: "Success", data: nil)
    render json: { success: true, message: message, data: data }, status: 200
  end

  # Common method to render create new resource
  def render_created(message: nil, data: nil)
    render json: { success: true, message: message, data: data }, status: 201
  end

  def render_serialize_data(serializer: nil, obj: nil, options: {}, message: nil, meta: {}, paginate: false)
    meta_options = { meta: meta }
    if ['ActiveRecord::AssociationRelation', 'ActiveRecord::Relation', 'ActiveRecord::Associations::CollectionProxy', "Array"].include?(obj.class.name)
      if paginate
        pagy, records = pagy(obj, page: params[:page] || 1, items: params[:items] || 10)
        meta_options[:meta][:pagination] = { count: pagy.count, items: pagy.items, from: pagy.from, to: pagy.to, first: 1, prev: pagy.prev, next: pagy.next, last: pagy.last, pages: pagy.pages }
      else
        records = obj
      end
      render json: {
        data: ActiveModelSerializers::SerializableResource.new(records, each_serializer: serializer, params: params, options: options, current_user: current_user),
        meta: meta_options[:meta],
        message: message,
        success: true
      }, status: :ok
    else
      render json: {
        data: ActiveModelSerializers::SerializableResource.new(obj, serializer: serializer, params: params, options: options, current_user: current_user),
        meta: meta_options[:meta],
        message: message,
        success: true
      }, status: :ok
    end
  end

  def render_404(message: 'Invalid URL')
    render json: { success: false, message: message, status_code: 404 }, status: 404
  end

  def render_bad_request(exception)
    render json: { success: false, message: exception.message, errors: [], status_code: 400 }, status: 400
  end

end
