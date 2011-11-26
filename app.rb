require './db'
require './index'


# API
db = DB.new('chat')


#stalker = db.search('Stalker').first
#db.add(:send_to => stalker[:id], :msg => 'Hi man!')
#db.add(:name => 'Alex', :age => 24)
#db.add(:name => 'Amely', :age => 27)
#db.add(:name => 'Aeron', :age => 20)
#db.add(:name => 'Stalker', :age => 30)
#db.add(:name => 'Mary', :age => 24, :tags => [1, 'many'])



#conditon = DB::Condition::Between.new(:age, 21..25)
#coll = db.where( conditon )
#p coll
#alex = coll.first
#p alex
#
#alex[:age] = 12
#db.update(alex)

coll = db.where(:age.lt 35)
m = coll.first
p m 

m[:age] = 50
db.update(m)

p db.where(:age.lt 35)
