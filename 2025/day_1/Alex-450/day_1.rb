# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_1/full_input_day_1_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_1/full_input_day_1.txt', chomp: true)

position = 50
@count = 0

puzzle_input.each do |line|
  direction = line.split('').first
  number_of_turns = line.scan(/\d/).join.to_i % 100

  if direction == 'L'
    position -= number_of_turns
  else
    position += number_of_turns
  end

  if position.negative?
    position = 100 + position
  end

  if position >= 100
    position = position - 100
  end

  if position.zero?
    @count += 1
  end
end

puts "Count is: #{@count}"
