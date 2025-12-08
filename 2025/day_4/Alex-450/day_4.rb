# frozen_string_literal: true

require 'pry'

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_4/full_input_day_4_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_4/full_input_day_4.txt', chomp: true)

def find_adjacent_points(point_index, line, line_index, puzzle_input)
  adjacent_points = []

  beginning_of_line = point_index.zero?
  end_of_line = point_index == line.chars.length - 1
  beginning_of_input = line_index.zero?
  end_of_input = line_index == puzzle_input.length - 1

  # find adjacent points same line
  adjacent_points << line[point_index - 1] unless beginning_of_line
  adjacent_points << line[point_index + 1] unless end_of_line

  # find adjacent points line above
  unless beginning_of_input
    adjacent_points << puzzle_input[line_index - 1][point_index]
    adjacent_points << puzzle_input[line_index - 1][point_index - 1] unless beginning_of_line
    adjacent_points << puzzle_input[line_index - 1][point_index + 1] unless end_of_line
  end

  # find adjacent points line below
  unless end_of_input
    adjacent_points << puzzle_input[line_index + 1][point_index]
    adjacent_points << puzzle_input[line_index + 1][point_index - 1] unless beginning_of_line
    adjacent_points << puzzle_input[line_index + 1][point_index + 1] unless end_of_line
  end

  adjacent_points
end

def accessible_roll?(adjacent_points, max_number)
  adjacent_points.count('@') < max_number
end

def count_accessible_rolls(puzzle_input, recursive)
  accessible_rolls = 0
  puzzle_input.each_with_index do |line, line_index|
    line.chars.each_with_index do |point, point_index|
      next unless point == '@'

      adjacent_points = find_adjacent_points(point_index, line, line_index, puzzle_input)
      accessible_roll = accessible_roll?(adjacent_points, 4)

      accessible_rolls += 1 if accessible_roll
      line[point_index] = 'x' if recursive && accessible_roll
    end
  end
  [accessible_rolls, puzzle_input]
end

# part 1
# answer: 1349
accessible_rolls = count_accessible_rolls(puzzle_input, false).first
puts accessible_rolls

# part 2
# answer: 8277
total_removed = 0

loop do
  accessible_rolls, puzzle_input = count_accessible_rolls(puzzle_input, true)

  total_removed += accessible_rolls
  break if accessible_rolls.zero?
end

puts total_removed
