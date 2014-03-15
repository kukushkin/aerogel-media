#
# Custom field types for Model#field ..., type: ...
#

module Model

  module Media

    class File
      attr_accessor :uid, :name

      def initialize( mongoid_value )
        case mongoid_value
        when nil
          @uid, @name = nil, nil
        when Array
          @uid, @name = mongoid_value[0], mongoid_value[1]
        when Hash
          @uid, @name = mongoid_value[:uid], mongoid_value[:name]
        when Media::File
          @uid, @name = mongoid_value.uid, mongoid_value.name
        else
          raise ArgumentError.new "Failed to create Media::File value from #{mongoid_value.class}"
        end
      end

      # Converts an object of this instance into a database friendly value.
      def mongoize
        uid.nil? ? nil : [ uid, name ]
      end

      class << self
        # Get the object as it was stored in the database, and instantiate
        # this custom class from it.
        def demongoize( object )
          object.nil? ? nil : Media::File.new( object )
        end

        # Takes any possible object and converts it to how it would be
        # stored in the database.
        def mongoize( object )
          Media::File.new(object).mongoize
        end

        # Converts the object that was supplied to a criteria and converts it
        # into a database friendly form.
        def evolve( object )
          case object
          when Media::File then object.mongoize
          else
            puts "** Model::Media::File.evolve(): object=#{object.inspect}"
            object
          end
        end
      end # class << self

    end # class File

    class Image < File
      # definitions here
    end # class Image

  end # module Media
end # module Model