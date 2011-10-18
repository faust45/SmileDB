require 'db.rb'
require 'index.rb'

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


db = DB.new('my_db')

#stalker = db.search('Stalker').first
#db.add(:send_to => stalker[:id], :msg => 'Hi man!')
#db.add(:name => 'Alex', :age => 24)
#db.add(:name => 'Amely', :age => 27)
#db.add(:name => 'Aeron', :age => 20)
#db.add(:name => 'Stalker', :age => 30)
#db.add(:name => 'Mary', :age => 23)


p db.where(:age.between(21..25))
#db.where(:age.lt 23)
