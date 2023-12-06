# frozen_string_literal: true

puzzle_input = File.readlines('./puzzle_inputs/day_4/full_input_day_4.txt', chomp: true)
sample_input = File.readlines('./puzzle_inputs/day_4/sample_input_day_4.txt', chomp: true)

def get_score(input)
  score = 0
  input.each do |line|
    winning_numbers, your_numbers = line.split("|")
    winning_numbers = winning_numbers.scan(/\d+/)[1..-1].map(&:to_i)
    your_numbers = your_numbers.scan(/\d+/).map(&:to_i)
    losing_numbers = your_numbers - winning_numbers
    winning_count = your_numbers.length - losing_numbers.length
    if winning_count == 1
      card_score = 1
    elsif winning_count > 1
      card_score = 1 * (2**(winning_count-1))
    else
      card_score = 0
    end
    score += card_score
  end
  score
end

score = get_score(puzzle_input)

# answer = 15205
p score
