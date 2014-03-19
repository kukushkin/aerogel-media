module Model

  define_field_type Media::File, :define_field_media_file
  define_field_type Media::Image, :define_field_media_image

  module ClassMethods

    def define_field_media_file( name, opts = {} )

      opts = {
        # defaults
        app: :file
      }.deep_merge opts

      unless self.respond_to? :dragonfly_accessor
        extend Dragonfly::Model
        extend Dragonfly::Model::Validations
      end

      type = opts[:type]
      define_field_mongoid name, type: type

      define_method "#{name}_uid" do
        type.new( self[name] ).uid
      end

      define_method "#{name}_uid=" do |value|
        self[name] = ( type.new( self[name] ).tap {|f| f.uid = value } ).mongoize
        value
      end

      define_method "#{name}_name" do
        type.new( self[name] ).name
      end

      define_method "#{name}_name=" do |value|
        self[name] = ( type.new( self[name] ).tap {|f| f.name = value } ).mongoize
        value
      end

      dragonfly_accessor name, app: opts[:app]

      alias_method :"dragonfly_accessor_#{name}=", :"#{name}="
      define_method "#{name}=" do |value|
        if Hash === value && value.key?(:tempfile) && value.key?( :filename )
          self.send :"dragonfly_accessor_#{name}=", Aerogel::Media::UploadedFile.new( value )
        else
          self.send :"dragonfly_accessor_#{name}=", value
        end
      end
    end

    def define_field_media_image( name, opts = {} )
      define_field_media_file name, { app: :image }.merge(opts)
      validates_property :mime_type, of: name, in: Media::Image::MIME_TYPES, message: :not_an_image
    end

  end # module ClassMethods

end # module Model