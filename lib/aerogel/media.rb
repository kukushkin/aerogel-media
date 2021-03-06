require 'aerogel/core'
require 'aerogel/media/version'
require 'aerogel/media/core'
require 'aerogel/media/field_types'
require 'aerogel/media/model'
require 'aerogel/media/uploaded_file'
# require 'aerogel/media/dragonfly_attachment'

module Aerogel

  # Finally, register module's root folder
  register_path File.join( File.dirname(__FILE__), '..', '..' )

  # configure module
  on_load do |app|
    app.register Aerogel::Media
  end

end
