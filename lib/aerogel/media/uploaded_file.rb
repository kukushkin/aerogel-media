module Aerogel::Media

  class UploadedFile
    attr_accessor :tempfile, :original_filename, :params

    # Parses Rack params hash for uploaded file
    #
    def initialize( params )
      self.params = params
      self.tempfile = params[:tempfile]
      self.original_filename = params[:filename]
    end

  end # class UploadedFile
end # module Aerogel::Media