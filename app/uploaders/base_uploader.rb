class BaseUploader < CarrierWave::Uploader::Base
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "#{model&.id.to_s.present? ? model&.id.to_s : Time.now.to_i}_#{original_filename}" if original_filename.present?
  end

end
