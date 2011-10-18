class DB
  DELIMITER = "----------\n"
  class WrongRecordType < Exception; end

  def initialize(file_name)
    @file  = File.open("#{file_name}.txt", File::RDWR|File::APPEND|File::CREAT)
    @index = Index.new(file_name)
  end

  def add(record)
    if record.is_a?(Hash)
      @file.write(DELIMITER)

      record[:id] ||= gen_id
      record.each do |(key, value)|
        @file.write("#{key}: #{value.to_db}\n")
      end
    else
      raise WrongRecordType.new
    end
  end

  # [DB::Condition.new, DB::Condition.new]  .check?(record)
  def where(*conditions)
    load_data
    @records.find_all do |record|
      # [true, true, true], [true, false, false]
      results =
        conditions.map do |condition|
          condition.check?(record) ? Condition::Success : Condition::Fail
        end

      if any_conditions_fail?(results)
        false
      else
        true
      end
    end
  end

  def update(id, attrs)
  end

  def get(id)
  end

  def delete(id)
  end

  def gen_id
    Time.now.utc.to_f.to_s.sub('.', '').to_i
  end

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

  private
    def load_data
      if @records == nil
        @records = []
        $/ = DELIMITER
        while (raw_record = @file.readline)
          record = {}
          raw_record.sub(DELIMITER, '').split("\n").each do |item|
            item.match /(.*):\s(.*)/ 
            record[$1.to_sym] = convert_value($2) 
          end

          @records << record
        end
      end

    rescue EOFError
    end

    def convert_value(value) 
      if value[0] == "\"" 
        value
      else
        value.to_i
      end
    end

    def any_conditions_fail?(conditons)
      conditons.include?(Condition::Fail)
    end
end
