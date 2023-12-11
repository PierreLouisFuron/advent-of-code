# frozen_string_literal: true

puzzle_input = File.readlines('./puzzle_inputs/day_7/full_input_day_7.txt', chomp: true)
sample_input = File.readlines('./puzzle_inputs/day_7/sample_input_day_7.txt', chomp: true)

LETTER_TO_NUMBER = {
  'A' => 14,
  'K' => 13,
  'Q' => 12,
  'J' => 11,
  'T' => 10
}.freeze

def create_cards_hash(input)
  cards_hash = {}
  input.each do |line|
    hand, bid = line.split(' ')
    cards_hash[hand] = bid
  end
  cards_hash
end

def add_pair_counts(cards_hash)
  cards_hash.each do |hand, bid|
    hand_array = hand.split('')
    pairs = {}
    hand_array.map { |card| pairs[card] = hand.count(card) }
    pairs.each_key { |card| pairs.delete(card) if pairs[card] < 2 }
    cards_hash[hand] = [bid, pairs.values.sort]
  end
end

def sort_equal_hands(seprated_hands)
  seprated_hands.each do |hands|
    next if hands.empty? || hands.length == 1
  end
end

def add_hand_as_integer(cards_hash)
  cards_hash.each do |key, value|
    cards_hash[key] = value + [key.split('').map { |card| LETTER_TO_NUMBER[card] || card }.map(&:to_i)]
  end
end

def split_hands(cards_hash)
  [
    cards_hash.select { |_key, value| value[1] == [] }, cards_hash.select { |_key, value| value[1] == [2] },
    cards_hash.select { |_key, value| value[1] == [2, 2] }, cards_hash.select { |_key, value| value[1] == [3] },
    cards_hash.select { |_key, value| value[1] == [2, 3] }, cards_hash.select { |_key, value| value[1] == [4] },
    cards_hash.select { |_key, value| value[1] == [5] }
  ]
end

def sort_split_hands(split_hands)
  split_hands = split_hands.reject { |hand| hand.empty? }
  split_hands.map do |grouped_hands|
    grouped_hands.sort_by { |_key, value| value[2] }
  end
end

def get_total_score(sorted_hands_array)
  score = 0
  multiplier = 1
  sorted_hands_array.each do |hand|
    score += (hand.last.first.to_i * multiplier)
    multiplier += 1
  end
  score
end

cards_hash = create_cards_hash(puzzle_input)
add_pair_counts(cards_hash)

# converted_hash = convert_hand_into_integers(cards_hash)
cards_hash = add_hand_as_integer(cards_hash)

# p cards_hash

# sorted_cards_hash = sort_hands(cards_hash)

split_hands = split_hands(cards_hash)

sorted_hands_array = sort_split_hands(split_hands)

sorted_hands_array = sorted_hands_array.flatten(1)

p sorted_hands_array.length

total_score = get_total_score(sorted_hands_array)

# Part 1 answer: 246409899
p total_score
