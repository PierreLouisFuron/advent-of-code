# frozen_string_literal: true

require 'pry'

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_3/full_input_day_3_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_3/full_input_day_3.txt', chomp: true)

# part 1
# answer 17435
max_joltage = 0

puzzle_input.each do |line|
  line_array = line.split('').map(&:to_i)

  top_number = line_array.sort.last(1)
  position = line_array.find_index(top_number.first)

  if position == line_array.length - 1
    next_largest = line_array[0..position-1].sort.last
    number = (next_largest.to_s + top_number.first.to_s).to_i
  else
    next_largest = line_array[position + 1..-1].sort.last
    number = (top_number.first.to_s + next_largest.to_s).to_i
  end

  max_joltage += number
end

puts "part 1: #{max_joltage}"
