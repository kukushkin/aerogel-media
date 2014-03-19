require 'dragonfly'
require 'dragonfly/model/validations'

module Aerogel::Media

  # Configures module Aerogel::Media
  #
  def self.registered(app)

    Dragonfly.app(:image).configure do
      plugin :imagemagick
      url_format '/media/images/:job/:basename.:ext'
      datastore :file, root_path: "media"

      # Returns human readable description of an attachment
      #
      define :description do
        file_name = name.present? ? name : ''
        "#{file_name} @ #{width}x#{height}, #{Aerogel::I18n.number_to_human_size size}"
      end
    end

    Dragonfly.app(:file).configure do
      url_format '/media/files/:job/:basename.:ext'
      datastore :file, root_path: "media"

      # Force any file to download
      response_header 'Content-Disposition' do |job, request, headers|
        "attachment; "+headers['Content-Disposition']
      end

      # Returns human readable description of an attachment
      #
      define :description do
        file_name = name.present? ? name : ''
        "#{file_name} @ #{Aerogel::I18n.number_to_human_size size}"
      end
    end

    app.use Dragonfly::Middleware, :image
    app.use Dragonfly::Middleware, :file

  end

end # module Aerogel::Media

