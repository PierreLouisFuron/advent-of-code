# frozen_string_literal: true

puzzle_input = File.read('./puzzle_inputs/day_1/full_input_day_1.txt').lines

PART_1_REGEX = /\d{1}/
PART_2_REGEX = /(?=(\d{1}|one|two|three|four|five|six|seven|eight|nine))/
NUMBERS = {
  'one' => 1,
  'two' => 2,
  'three' => 3,
  'four' => 4,
  'five' => 5,
  'six' => 6,
  'seven' => 7,
  'eight' => 8,
  'nine' => 9
}.freeze

answer = 0

def first_and_last(line, regex)
  first_and_last = line.scan(regex).flatten
  [first_and_last[0], first_and_last[-1]].map { |number| NUMBERS[number] || number }
end

puzzle_input.each do |line|
  first_and_last = first_and_last(line, PART_1_REGEX)

  result = first_and_last.join.to_s.to_i

  answer += result
end

print "Part 1 answer: #{answer}"

answer2 = 0

puzzle_input.each do |line|
  first_and_last = first_and_last(line, PART_2_REGEX)
  result = first_and_last.join.to_s.to_i
  answer2 += result
end

print "\n"
print "Part 2 answer: #{answer2}"
print "\n"

# tests

if answer != 54_644
  print 'Part 1 test failed ❌'
else
  print 'Part 1 test passed ✅'
end

print "\n"

if answer2 != 53_348
  print 'Part 2 test failed ❌'
else
  print 'Part 2 test passed ✅'
end

print "\n"
