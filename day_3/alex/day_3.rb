# frozen_string_literal: true

sample_input = File.readlines('./puzzle_inputs/day_3/sample_input_day_3.txt', chomp: true)
full_input = File.readlines('./puzzle_inputs/day_3/full_input_day_3.txt', chomp: true)

SYMBOL_REGEX = /\W/
INTEGER_REGEX = /\d+/
ASTERISK_REGEX = /\*/

def positions_by_regex(line, regex)
  line.enum_for(:scan, regex).map { Regexp.last_match.begin(0) }
end

def get_number_positions(line)
  positions_by_regex(line, INTEGER_REGEX)
end

def get_numbers(line)
  line.scan(INTEGER_REGEX).map(&:to_i)
end

def get_symbol_positions(line)
  positions_by_regex(line.gsub('.', 'F'), SYMBOL_REGEX)
end

def get_asterisk_positions(line)
  positions_by_regex(line, ASTERISK_REGEX)
end

def check_symbol_positions(symbol_positions, symbol_possible_start_position, symbol_possible_end_position, part_number)
  symbol_positions.each do |symbol_position|
    break if part_number

    if (symbol_position >= symbol_possible_start_position) && (symbol_position <= symbol_possible_end_position)
      part_number = true
    end
  end
  part_number
end

def part_number?(number, number_start_position, line_number, input)
  part_number = false
  number_length = number.to_s.length
  number_end_position = number_start_position + number_length - 1
  symbol_possible_start_position = number_start_position.zero? ? 0 : number_start_position - 1
  symbol_possible_end_position = number_end_position + 1

  symbol_positions_same_line = get_symbol_positions(input[line_number])
  part_number = check_symbol_positions(symbol_positions_same_line, symbol_possible_start_position,
                                       symbol_possible_end_position, part_number)

  if line_number.positive? && !part_number
    symbol_positions_line_above = get_symbol_positions(input[line_number - 1])

    part_number = check_symbol_positions(symbol_positions_line_above, symbol_possible_start_position,
                                         symbol_possible_end_position, part_number)
  end

  if input[line_number] != input.last && !part_number
    symbol_positions_line_below = get_symbol_positions(input[line_number + 1])

    part_number = check_symbol_positions(symbol_positions_line_below, symbol_possible_start_position,
                                         symbol_possible_end_position, part_number)
  end
  part_number
end

def get_part_number_totals(input)
  total = 0
  input.each_with_index do |line, input_index|
    numbers = get_numbers(line)
    number_starting_positions = get_number_positions(line)

    numbers.each_with_index do |number, i|
      total += number if part_number?(number, number_starting_positions[i], input_index, input)
    end
  end
  total
end

total_part_numbers = get_part_number_totals(full_input)

# answer = 537732
# test
print "Answer part 1: #{total_part_numbers}"
print "\n"
print 'Test failed ❌' if total_part_numbers != 537_732
print "\n"
print 'Test passed ✅' if total_part_numbers == 537_732
