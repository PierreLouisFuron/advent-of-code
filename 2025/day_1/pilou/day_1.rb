# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_1/full_input_day_1_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_1/full_input_day_1.txt', chomp: true)

def count_multiples(a, b)
  (b / 100) - ((a - 1) / 100)
end

def move_cursor(current_position, command)
  direction = command[0]
  distance = command[1..].to_i

  distance = -distance if direction == 'L'

  new_cursor = current_position + distance

  # counter = ([current_position, new_cursor].min..[current_position, new_cursor].max).map { |n| n % 100 }.count(0)
  counter = count_multiples([current_position, new_cursor].min, [current_position, new_cursor].max)
  # It would be way more elegant to use an euclidian division here... but that just works
  counter -= 1 if current_position == 0

  # [new_cursor % 100, (new_cursor < 0 && current_position != 0) || new_cursor > 99 || new_cursor == 0 ? 1 : 0]
  [new_cursor % 100, counter]
end

cursor = 50
password = 0
puzzle_input.each do |_line|
  cursor, increase_slot = move_cursor(cursor, _line)
  # password += 1 if cursor.zero?
  password += increase_slot
end

p password
