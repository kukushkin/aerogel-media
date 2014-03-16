require 'dragonfly'
require 'dragonfly/model/validations'

module Aerogel::Media

  # Configures module Aerogel::Media
  #
  def self.registered(app)

    Dragonfly.app.configure do
      plugin :imagemagick
      url_format '/media/:job/:basename.:ext'
      datastore :file, root_path: "media"
    end
    app.use Dragonfly::Middleware
  end

end # module Aerogel::Media

