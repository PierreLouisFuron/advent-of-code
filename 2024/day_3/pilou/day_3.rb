# frozen_string_literal: true

DAY = 1
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt"
INPUT_FILE_PATH_TEST = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test.txt"

# puzzle_input = File.readlines('small_input_day_3.txt', chomp: true)
# puzzle_input = File.readlines('small_input_2_day_3.txt', chomp: true)
puzzle_input = File.readlines('full_input_day_3.txt', chomp: true)
total = 0
is_mul_enabled = true
puzzle_input.each do |line|
  # regex = /mul\((\d+),(\d+)\)/
  # regex = /mul\(\d+,\d+\)/
  regex = /mul\(\d+,\d+\)|do\(\)|don't\(\)/
  matches = line.scan(regex)
  matches.each do |match|
    if match == 'do()'
      is_mul_enabled = true
    elsif match == "don't()"
      is_mul_enabled = false
    elsif is_mul_enabled
      num1, num2 = match.scan(/mul\((\d+),(\d+)\)/)[0].map(&:to_i)
      total += num1 * num2
    end
    # num1, num2 = match.map(&:to_i)
    # total += num1 * num2
  end
end

print total
