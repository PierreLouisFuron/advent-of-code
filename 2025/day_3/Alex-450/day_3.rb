# frozen_string_literal: true

require 'pry'

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_3/full_input_day_3_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_3/full_input_day_3.txt', chomp: true)

def get_largest_number(full_number, output_length)
  result = []
  to_remove = full_number.length - output_length

  full_number.each do |number|
    while to_remove.positive? && result.any? && number > result.last
      result.pop
      to_remove -= 1
    end
    result << number
  end

  result.first(output_length).join.to_i
end

# part 1
# answer 17435
max_joltage = 0

puzzle_input.each do |line|
  line_array = line.split('').map(&:to_i)
  largest_number = get_largest_number(line_array, 2)

  max_joltage += largest_number
end

puts 'correct result part 1 ✅' if max_joltage == 17_435
puts "part 1: #{max_joltage}"

# part 2
# answer: 172886048065379

max_joltage = 0

puzzle_input.each do |line|
  line_array = line.split('').map(&:to_i)

  largest_number = get_largest_number(line_array, 12)
  max_joltage += largest_number
end

puts 'correct result part 2 ✅' if max_joltage == 172_886_048_065_379
puts "part 2: #{max_joltage}"
