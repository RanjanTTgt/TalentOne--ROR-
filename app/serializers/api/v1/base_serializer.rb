class Api::V1::BaseSerializer < ActiveModel::Serializer

  def options
    HashWithIndifferentAccess.new(instance_options[:options]) rescue {}
  end

  def params
    instance_options[:params] rescue nil
  end

  def current_user
    instance_options[:current_user] rescue nil
  end
end
