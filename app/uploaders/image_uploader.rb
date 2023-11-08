class ImageUploader < BaseUploader

  process :crop_image

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [100, 100]
  end

  def crop_image
    unless $image_crop_x.blank?
      manipulate! do |image|
        x = $image_crop_x.to_f
        y = $image_crop_y.to_f
        w = $image_crop_w.to_f
        h = $image_crop_h.to_f
        image.crop([[w, h].join('x'), [x, y].join('+')].join('+'))
      end
    end
  end

  def extension_allowlist
    %w(jpg jpeg gif png webp)
  end

end
