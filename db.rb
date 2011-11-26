require './extensions'
require './conditions'
require './index'
require 'yaml'


class DB
  DELIMITER = "----------\n"
  class WrongRecordType < Exception; end

  def initialize(file_name)
    @file  = File.open("#{file_name}.txt", File::RDWR|File::APPEND|File::CREAT)
    @file_read  = File.open("#{file_name}.txt", File::RDONLY|File::APPEND|File::CREAT)
    @index = Index.new(file_name)
  end

  def clear
    @file.truncate(0)
  end

  def add(record)
    raise WrongRecordType.new unless record.is_a?(Hash)
      
    record[:id]   ||= gen_id
    record[:_rev] ||= gen_rev

    @file.write(DELIMITER)
    @file.write(dump(record))
    @file.flush

    @records_hash = nil
  end

  # [DB::Condition.new, DB::Condition.new]  .check?(record)
  def where(*conditions)
    load_data
    @records_hash.values.map do |record|
      # results = [true, true, true], [true, false, false]
      results =
        conditions.map do |condition|
          condition.check?(record) ? Condition::Success : Condition::Fail
        end

      if all_conditions_success?(results)
        record.clone
      end
    end.compact.sort{|el, other| el[:id] <=> other[:id]}
  end

  def update(record)
    raise "For update require :id field" if record[:id] == nil

    record[:_rev] += 1
    add(record)
  end

  def delete(record)
    record[:_delete] = true 
    update(record)
  end

  def get(id)
  end

  private
    def gen_id
      Time.now.utc.to_f.to_s.sub('.', '').to_i
    end

    def gen_rev
      1
    end

    def load_data
      if @records_hash == nil
        @records_hash = {} 
        $/ = DELIMITER
        @file_read.rewind
        while (raw_record = @file_read.readline)
          record = load(raw_record)
          @records_hash[record[:id]] = record

          if record[:_delete]
            @records_hash.delete(record[:id])
          end
        end
      end

    rescue EOFError
    end

    def all_conditions_success?(conditons)
      !conditons.include?(Condition::Fail)
    end

    def dump(record)
      text = ''
      record.each do |(key, value)|
        text << "#{key}: #{value.to_db}\n"
      end

      text
    end

    def load(text)
      record = {}
      text.sub(DELIMITER, '').split("\n").each do |item|
        item.match /(.*):\s(.*)/ 
        record[$1.to_sym] = convert_value($2) 
      end

      record
    end

    def convert_value(value) 
      if value[0] == "\"" 
        value[1..value.length - 2]
      elsif value[0] == "["
        convert_array(value)
      else
        value.to_i
      end
    end

    def convert_array(value)
      value[1..value.length - 2].split(', ').map do |el|
        convert_value(el) 
      end
    end
end
