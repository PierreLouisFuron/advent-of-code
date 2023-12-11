# frozen_string_literal: true

puzzle_input = File.readlines('./puzzle_inputs/day_6/full_input_day_6.txt', chomp: true)
# sample_input = File.readlines('./puzzle_inputs/day_6/sample_input_day_6.txt', chomp: true)

def get_record_beating_count(time, record)
  record_beating_options = 0
  (0..time).each do |second|
    distance = second * (time - second)
    record_beating_options += 1 if distance > record
  end
  record_beating_options
end

def one_race_numbers(input)
  [input.first.scan(/\d+/).join, input.last.scan(/\d+/).join]
end

def calculate_winning_options(input)
  record_beating_options = []
  input.first.scan(/\d+/).length.times do |race|
    time = input.first.scan(/\d+/)[race].to_i
    record = input.last.scan(/\d+/)[race].to_i
    record_beating_option_count = get_record_beating_count(time, record)
    record_beating_options << record_beating_option_count
  end
  record_beating_options.inject(:*)
end

winning_amount = calculate_winning_options(puzzle_input)

# Answer part 1: 781200
print winning_amount
print "\n"

# For part 2 the numbers should be joined together:
# There's really only one race - ignore the spaces between the numbers on each line.
input = one_race_numbers(puzzle_input)

winning_amount_p2 = calculate_winning_options(input)

# Answer part 2: 49240091
print winning_amount_p2
print "\n"
