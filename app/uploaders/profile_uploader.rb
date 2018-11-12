# encoding utf-8
# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class ProfileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :active_record
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def url
    "students/#{model.id}/photo?hash=#{model.photo_before_type_cast}"
  end
  
  configure do |config|
    config.remove_previously_stored_files_after_update = false
    config.root = Rails.root
  end

  class FilelessIO < StringIO
    attr_accessor :original_filename
    attr_accessor :content_type
  end

  # Param must be a hash with to 'base64_contents' and 'filename'.
  def cache!(file)

    #avoid the carrier_wave to create duplicate database entry of same file due file termination case 	  
    if (defined? file.original_filename) && (file.original_filename.is_a? String)
      file.original_filename.downcase!
    end  

    if file.respond_to?(:has_key?) && file.has_key?(:base64_contents) && file.has_key?(:filename)
      local_file = FilelessIO.new(Base64.decode64(file[:base64_contents]))
      local_file.original_filename = file[:filename]
      extension = File.extname(file[:filename])[1..-1]
      local_file.content_type = Mime::Type.lookup_by_extension(extension).to_s
      super(local_file)
    else
      super(file)
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
