# frozen_string_literal: true

puzzle_input = File.readlines('./puzzle_inputs/day_4/full_input_day_4.txt', chomp: true)
# sample_input = File.readlines('./puzzle_inputs/day_4/full_input_day_4_test.txt', chomp: true)

def get_winning_count(line)
  winning_numbers, your_numbers = line.split('|')
  winning_numbers = winning_numbers.scan(/\d+/)[1..].map(&:to_i)
  your_numbers = your_numbers.scan(/\d+/).map(&:to_i)
  losing_numbers = your_numbers - winning_numbers
  your_numbers.length - losing_numbers.length
end

def get_card_score(winning_count)
  if winning_count == 1
    winning_count
  elsif winning_count > 1
    1 * (2**(winning_count - 1))
  else
    0
  end
end

def add_copied_cards(current_card_index, winning_count, earned_scrapcards)
  return unless winning_count.positive?

  (current_card_index + 1..current_card_index + winning_count).each do |new_card_index|
    earned_scrapcards[new_card_index] += earned_scrapcards[current_card_index]
  end
end

def get_score(input)
  score = 0
  earned_scrapcards = Array.new(input.length, 1)

  input.each_with_index do |line, current_card_index|
    winning_count = get_winning_count(line)
    card_score = get_card_score(winning_count)
    add_copied_cards(current_card_index, winning_count, earned_scrapcards)

    score += card_score
  end
  [score, earned_scrapcards.sum]
end

score, cards = get_score(puzzle_input)

# answer = score = 15205, cards = 6189740
print score
print "\n"
print cards
print "\n"
