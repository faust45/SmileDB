class Symbol
  def gt(value)
    DB::Condition::GT.new(self, value)
  end

  def lt(value)
    DB::Condition::LT.new(self, value)
  end

  def like(value)
    DB::Condition::LIKE.new(self, value)
  end

  def between(value)
    DB::Condition::Between.new(self, value)
  end
end


class Integer
  def to_db
    to_s
  end
end

class String
  def to_db
    "\"#{self}\""
  end
end


