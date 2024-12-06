# frozen_string_literal: true

puzzle_input = File.readlines('./puzzle_inputs/day_7/full_input_day_7.txt', chomp: true)
# sample_input = File.readlines('./puzzle_inputs/day_7/sample_input_day_7.txt', chomp: true)

LETTER_TO_NUMBER_PART_1 = {
  'A' => 14,
  'K' => 13,
  'Q' => 12,
  'J' => 11,
  'T' => 10
}.freeze

LETTER_TO_NUMBER_PART_2 = {
  'A' => 14,
  'K' => 13,
  'Q' => 12,
  'J' => -1,
  'T' => 10
}.freeze

JOKER_VALUE = 'J'

def create_cards_hash(input)
  cards_hash = {}
  input.each do |line|
    hand, bid = line.split(' ')
    cards_hash[hand] = { 'bid' => bid.to_i }
  end
  cards_hash
end

def create_hands_array(hand, part)
  if part == 2
    # NOTE: ignore jokers for now and handle them after
    hand.split('').reject { |card| card == JOKER_VALUE }
  else
    hand.split('')
  end
end

def add_pair_counts(cards_hash, part)
  cards_hash.each do |hand, bid|
    hand_array = create_hands_array(hand, part)
    pairs = {}
    hand_array.map { |card| pairs[card] = hand.count(card) }
    pairs.each_key { |card| pairs.delete(card) if pairs[card] < 2 }
    cards_hash[hand] = bid.merge({ 'hand_value' => pairs.values.sort })
  end
end

def add_hand_as_integer(cards_hash, letter_to_number_map)
  cards_hash.each do |key, value|
    cards_hash[key] = value.merge({ 'hand_as_integers' => [key.split('').map do |card|
                                                             letter_to_number_map[card] || card
                                                           end.map(&:to_i)] })
  end
end

def select_by_value(cards_hash, pair_value)
  cards_hash.select { |_key, value| value['hand_value'] == pair_value }
end

def split_hands(cards_hash)
  [
    select_by_value(cards_hash, []), select_by_value(cards_hash, [2]),
    select_by_value(cards_hash, [2, 2]), select_by_value(cards_hash, [3]),
    select_by_value(cards_hash, [2, 3]), select_by_value(cards_hash, [4]),
    select_by_value(cards_hash, [5])
  ]
end

def sort_split_hands(split_hands)
  split_hands = split_hands.reject(&:empty?)
  split_hands.map do |grouped_hands|
    grouped_hands.sort_by { |_key, value| value['hand_as_integers'] }
  end
end

def get_total_score(sorted_hands_array)
  score = 0
  multiplier = 1
  sorted_hands_array.each do |_key, value|
    score += (value['bid'] * multiplier)
    multiplier += 1
  end
  score
end

def get_answer_part1(input)
  cards_hash = create_cards_hash(input)
  add_pair_counts(cards_hash, 1)
  cards_hash = add_hand_as_integer(cards_hash, LETTER_TO_NUMBER_PART_1)
  split_hands = split_hands(cards_hash)
  sorted_hands_array = sort_split_hands(split_hands)
  sorted_hands_array = sorted_hands_array.flatten(1)
  get_total_score(sorted_hands_array)
end

total_score = get_answer_part1(puzzle_input)
# Part 1 answer: 246409899
if total_score == 246_409_899
  print 'Part 1 tests passed ✅'
else
  print 'Part 1 tests failed ❌'
end

# Part 2:

def handle_jokers(cards_hash)
  cards_hash.map do |hand, values|
    next unless hand.include?(JOKER_VALUE)

    joker_count = hand.count(JOKER_VALUE)
    existing_pair_value = values['hand_value']

    values['hand_value'] = get_new_hand_score(existing_pair_value, joker_count)
  end
end

def get_new_hand_score(existing_pair_value, joker_count)
  if existing_pair_value == []
    joker_count < 5 ? [joker_count + 1] : [joker_count]
  elsif [[2], [3]].include?(existing_pair_value)
    [(existing_pair_value.first + joker_count)]
  elsif existing_pair_value == [2, 2]
    [2, 3]
  elsif existing_pair_value == [4]
    [5]
  end
end

def get_answer_part2(input)
  cards_hash = create_cards_hash(input)
  add_pair_counts(cards_hash, 2)
  handle_jokers(cards_hash)
  cards_hash = add_hand_as_integer(cards_hash, LETTER_TO_NUMBER_PART_2)
  split_hands = split_hands(cards_hash)
  sorted_hands_array = sort_split_hands(split_hands)
  sorted_hands_array = sorted_hands_array.flatten(1)
  get_total_score(sorted_hands_array)
end

# Part 2 answer: 244848487
total_score_part2 = get_answer_part2(puzzle_input)
print "\n"
if total_score_part2 == 244_848_487
  print 'Part 2 tests passed ✅'
else
  print 'Part 2 tests failed ❌'
end
print "\n"
