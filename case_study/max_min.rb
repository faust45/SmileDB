#Find max
a = [1, 2, 3, 9, 8, 7, 6, 5]


max = a[0] 
a.each do |el|
  if max < el
    max = el
  end
end

puts 'Max:'
puts max

min = a[0] 
a.each do |el|
  if el < min
    min = el
  end
end

puts 'Min:'
puts min

