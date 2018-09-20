class LicenseDecoderController < ApplicationController
  def upload
    uploaded_io = params[:license]
    puts(uploaded_io)
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  def index

  end
end
