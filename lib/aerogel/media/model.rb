module Model

  define_field_type Media::File, :define_field_media_file
  define_field_type Media::Image, :define_field_media_file

  module ClassMethods

    def define_field_media_file( name, opts = {} )
      unless self.respond_to? :dragonfly_accessor
        extend Dragonfly::Model
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

      dragonfly_accessor name

      alias_method :"dragonfly_accessor_#{name}=", :"#{name}="
      define_method "#{name}=" do |value|
        if Hash === value && value.key?(:tempfile) && value.key?( :filename )
          self.send :"dragonfly_accessor_#{name}=", Aerogel::Media::UploadedFile.new( value )
        else
          self.send :"dragonfly_accessor_#{name}=", value
        end
      end
      puts "** field #{name}, type:#{type} -- instantiated"
    end

    def define_field_media_image( name, opts = {} )
      define_field_media_file( name, opts )
      puts "** field #{name}, type:Media::Image -- instantiated"
    end

  end # module ClassMethods

end # module Model