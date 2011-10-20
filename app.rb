require './db'
require './index'


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
