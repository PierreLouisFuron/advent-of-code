# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_1/full_input_day_1_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_1/full_input_day_1.txt', chomp: true)

# part 1
position = 50
count = 0

puzzle_input.each do |line|
  direction = line.split('').first
  number_of_turns = line.scan(/\d/).join.to_i % 100

  number_of_turns = -number_of_turns if direction == 'L'

  position += number_of_turns

  count += 1 if (position % 100).zero?
end

puts "part 1: #{count}"

# part 2
position = 50
count = 0

puzzle_input.each do |line|
  direction = line.split('').first
  number_of_turns = line.scan(/\d/).join.to_i

  number_of_turns.times do
    position += 1 if direction == 'L'
    position -= 1 if direction == 'R'

    count += 1 if (position % 100).zero?
  end
end

puts "part 2: #{count}"
