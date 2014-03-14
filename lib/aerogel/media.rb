require 'aerogel/core'
require "aerogel/media/version"

module Aerogel
  module Media
    # Your code goes here...
  end

  # Finally, register module's root folder
  register_path File.join( File.dirname(__FILE__), '..', '..' )
end

