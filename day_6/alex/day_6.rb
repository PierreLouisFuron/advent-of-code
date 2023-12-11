# frozen_string_literal: true

puzzle_input = File.readlines('./puzzle_inputs/day_6/full_input_day_6.txt', chomp: true)
sample_input = File.readlines('./puzzle_inputs/day_6/sample_input_day_6.txt', chomp: true)

def winning_possibilites(time, record)
  record_beating_options = 0
  (0..time).each do |second|
    distance = second * (time - second)
    record_beating_options += 1 if distance > record
  end
  record_beating_options
end

def calculate_winning_options(input)
  record_beating_options = []
  input.first.scan(/\d+/).length.times do |race|
    time = input.first.scan(/\d+/)[race].to_i
    record = input.last.scan(/\d+/)[race].to_i
    winning_option_count = winning_possibilites(time, record)
    record_beating_options << winning_option_count
  end
  record_beating_options.inject(:*)
end

winning_amount = calculate_winning_options(puzzle_input)

# Answer part 1: 781200
print winning_amount
print "\n"
