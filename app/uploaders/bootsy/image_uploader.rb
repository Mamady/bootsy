module Bootsy
  class ImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage Bootsy.storage

    def store_dir
      "#{Bootsy.store_dir}/posts/images/#{model.id}"
    end

    process resize_to_limit: [1160, 2000]

    version :large do
      process resize_to_fit: [
        Bootsy.large_image[:width], Bootsy.large_image[:height]
      ]
    end

    version :medium do
      process resize_to_fit: [
        Bootsy.medium_image[:width], Bootsy.medium_image[:height]
      ]
    end

    version :small do
      process resize_to_fit: [
        Bootsy.small_image[:width], Bootsy.small_image[:height]
      ]
    end

    version :thumb do
      process resize_to_fill: [60, 60]
    end

    def extension_white_list
      %w(jpg jpeg gif png)
    end

    def filename
      if model.image_name.present?
        "#{model.image_name}.jpg"
      else
        original_filename
      end
    end
  end
end
