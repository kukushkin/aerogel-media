require 'dragonfly'

module Aerogel::Media

  # Configures module Aerogel::Mailer
  #
  def self.registered(app)
    Dragonfly.app.configure do
      plugin :imagemagick
      url_format '/media/:job/:name.:ext'
      datastore :file, root_path: "media"
    end
    app.use Dragonfly::Middleware
  end

end # module Aerogel::Media

