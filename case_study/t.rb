a = [1, 2, 3, 4, 5, 6, 7]

a.each do |item|
  if 5 < item 
    #puts item
  end
end


a = ['a', 'b', 'c', 'd', 'f', 'f', 'a']

hash = {}
a.each do |el|
  if hash[el] == nil
    hash[el] = 0
  end

  hash[el] += 1 
end

#{'a' => 0, 'b' => 1}
hash.each do |(key, counter)|
  if counter == 2
    puts key
  end
end

a = ['a', 'b', 'e', 'r', 'k', 't', 't', 't', 't']

counter = 0
a.each do |el|
  if el == 't'
    counter += 1
  end
end

puts counter

#a = {:name => 'Mary', :age => 33}
#a[:name]

records = [
  {:name => 'Alex',  :tags => ['music', 'programming', 'air']},
  {:name => 'Mary',  :tags => ['hack', 'dance', 'pockert']},
  {:name => 'Steve', :tags => ['air', 'dance', 'programming']},
  {:name => 'Mila',  :tags => ['Films', 'dance', 'fly']}
]

# programming => 2
# dance => 3

1 'a'
hash = {}
records.each do |person|
  person[:tags].each do |tag|
    if hash[tag] == nil
      hash[tag] = 0
    end

    hash[tag] += 1
  end
end

puts hash.inspect
{"music"=>1, "programming"=>2, "air"=>2, "hack"=>1, "dance"=>3, "pockert"=>1, "Films"=>1, "fly"=>1}





