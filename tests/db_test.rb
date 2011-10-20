require "rubygems"
require "test/unit"
require './db'


class DBTest < Test::Unit::TestCase

  def setup
    @db = DB.new('test_my_db')
    @db.clear
  end

  def test_should_be_ok
    person = {:name => 'Amely', :age => 27}
    @db.add(person)

    result = @db.where :age.gt(20)
    assert_equal result.first, person
  end

end

