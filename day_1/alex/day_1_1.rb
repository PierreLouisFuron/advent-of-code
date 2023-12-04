puzzle_input = File.read('./puzzle_inputs/day_1/full_input_day_1.txt').lines

answer = 0

puzzle_input.each do |line|
  number = line.scan(/\d{1}/)

  first = number[0]
  last = number[-1]
  result = "#{first}#{last}".to_i

  answer += result
end

p "Part 1 answer: #{answer}"

answer2 = 0

numbers = {
  'one' => 1,
  'two' => 2,
  'three' => 3,
  'four' => 4,
  'five' => 5,
  'six' => 6,
  'seven' => 7,
  'eight' => 8,
  'nine' => 9
}

puzzle_input.each do |line|
  results = []
  line.length.times do |i|
    test = line[i..-1].scan(/(\d{1}|one|two|three|four|five|six|seven|eight|nine)/)
    results << test
  end

  results = results.reject! { |r| r.empty? }

  first = results.first[0].first
  last = results.last[-1].first

  first = numbers[first] if numbers[first]

  last = numbers[last] if numbers[last]

  result = "#{first}#{last}".to_i

  answer2 += result
end

p "Part 2 answer: #{answer2}"

# tests

if answer != 54644
  p 'Part 1 test failed ❌'
else
  p 'Part 1 test passed ✅'
end

if answer2 != 53348
  p 'Part 2 test failed ❌'
else
  p 'Part 2 test passed ✅'
end
