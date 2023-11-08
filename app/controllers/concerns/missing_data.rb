module MissingData
  # Render and error if parameters are missing
  def missing_params!(fields)
    missing_data(params, fields, 1002)
  end

  # Render and error if headers are missing
  def missing_headers!(fields)
    missing_data(request.headers, fields, 1001)
  end

  # Shared Logic of missing params and headers
  def missing_data(data, required_fields, error_code)
    missing = []

    if required_fields.is_a?(Array)
      required_fields.each { |f| missing << f unless data[f].present? }
    else
      missing << required_fields unless data[required_fields].present?
    end
    @errors = missing.map{|field| {field: field, message: "#{field} parameter is missing"} } if missing.present?
    return render_error(message: "missing parameters: #{missing.join(', ')}", errors: @errors) unless missing.blank?
    false
  end
end