class DB
 module Condition
    Success = true 
    Fail    = false 

    class GT
      def initialize(field_name, value)
        @field_name = field_name
        @value = value
      end

      def check?(record)
        if record[@field_name]
          @value < record[@field_name]
        end
      end
    end

    class LT
      def initialize(field_name, value)
        @field_name = field_name
        @value = value
      end

      def check?(record)
        if record[@field_name]
          record[@field_name] < @value 
        end
      end
    end

    class Between 
      def initialize(field_name, value)
        @field_name = field_name
        @value = value
      end

      def check?(record)
        if record[@field_name]
          @value.first < record[@field_name] and
            @value.last > record[@field_name]
        end
      end
    end

    class LIKE
      def initialize(field_name, value)
        @field_name = field_name
        @value = value
      end

      def check?(record)
        if record[@field_name]
          record[@field_name].to_s.downcase.match @value.to_s.downcase
        end
      end
    end
  end
end
