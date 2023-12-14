# frozen_string_literal: true

DAY = 9
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt".freeze
INPUT_FILE_PATH_TEST = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test.txt".freeze

def extrapolate(history)
  return [0, 0] if history.all? { |v| v.zero? }

  new_history = []
  (0..history.length - 2).to_a.each do |value_index|
    new_history << history[value_index + 1] - history[value_index]
  end
  extrapolated_numbers = extrapolate(new_history)
  [history.first - extrapolated_numbers[0], history.last + extrapolated_numbers[1]]
end

def main(input_file)
  total_1 = 0
  total_2 = 0
  File.readlines(input_file, chomp: true).each do |line|
    history = line.split(' ').map(&:to_i)
    extrapolated_numbers = extrapolate(history)
    total_1 += extrapolated_numbers[1]
    total_2 += extrapolated_numbers[0]
  end
  p "Total_1 : #{total_1}"
  p "Total_2 : #{total_2}"
end

main(INPUT_FILE_PATH_TEST)
main(INPUT_FILE_PATH)
