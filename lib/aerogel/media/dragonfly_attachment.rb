module Dragonfly
  module Model
    class Attachment

      def description
        file_name = name.present? ? name : ''
        if image?
          "#{file_name} @ #{width}x#{height}, #{Aerogel::I18n.number_to_human_size size}"
        else
          "#{file_name} @ #{Aerogel::I18n.number_to_human_size size}"
        end
      end
    end # class Attachment
  end # module Model
end # module Dragonfly