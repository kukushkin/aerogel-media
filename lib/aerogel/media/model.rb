module Model

  define_field_type Dragonfly, :define_field_dragonfly

  module ClassMethods
    def define_field_dragonfly( name, opts = {} )
      unless self.respond_to? :dragonfly_accessor
        extend Dragonfly::Model
      end
      field "#{name}_uid".to_sym, type: String
      field "#{name}_name".to_sym, type: String # provides support for :ext in urls
      dragonfly_accessor name
    end
  end # module ClassMethods

end # module Model