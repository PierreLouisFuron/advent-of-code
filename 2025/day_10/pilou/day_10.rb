# frozen_string_literal: true

test_parameter = ARGV.first
is_test_mode_enabled = ['-t', '--test'].include?(test_parameter)
filepath = "./2025/puzzle_inputs/day_10/full_input_day_10#{'_test' if is_test_mode_enabled}.txt"
puzzle_input = File.readlines(filepath, chomp: true)

puzzle_input.each do |line|
  p line
end
