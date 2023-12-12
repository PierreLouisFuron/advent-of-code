# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/AbcSize
# rubocop:disable

FIVE_OF_A_KIND = 7
FOUR_OF_A_KIND = 6
FULL_HOUSE = 5
THREE_OF_A_KIND = 4
TWO_PAIRS = 3
ONE_PAIR = 2
HIGH_CARD = 1

DAY = 7
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt".freeze
INPUT_FILE_PATH_TEST = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test.txt".freeze

CARD_VALUE = {
  'A' => 14,
  'K' => 13,
  'Q' => 12,
  # 'J' => 11,
  'J' => 1,
  'T' => 10,
  '9' => 9,
  '8' => 8,
  '7' => 7,
  '6' => 6,
  '5' => 5,
  '4' => 4,
  '3' => 3,
  '2' => 2
}.freeze

# def get_hand_type(hand) # PART 1
#   tmp = {}
#   hand.each_char do |card|
#     tmp[card] = tmp.key?(card) ? tmp[card] + 1 : 1
#   end
#   return HIGH_CARD if tmp.length == 5
#   return ONE_PAIR if tmp.length == 4
#   return TWO_PAIRS if tmp.length == 3 && tmp.value?(2)
#   return THREE_OF_A_KIND if tmp.length == 3 && tmp.value?(3)
#   return FOUR_OF_A_KIND if tmp.length == 2 && (tmp.values[0] == 1 || tmp.values[0] == 4)
#   return FULL_HOUSE if tmp.length == 2 && (tmp.values[0] == 2 || tmp.values[0] == 3)
#   return FIVE_OF_A_KIND if tmp.length == 1

#   'ERROR'
# end

def convert_hand_to_hashmap(hand)
  hand_hash = {}
  hand.each_char do |card|
    hand_hash[card] = hand_hash.key?(card) ? hand_hash[card] + 1 : 1
  end
  hand_hash
end

def get_hand_type(hand)
  hand_hash = convert_hand_to_hashmap(hand)

  return FIVE_OF_A_KIND if hand_hash.length == 1

  if hand_hash.key?('J')
    hand_without_jokers = hand_hash.clone
    hand_without_jokers.delete('J')
    biggest_combination = largest_hash_key(hand_without_jokers)[0]
    hand_hash[biggest_combination] += hand_hash['J']
    hand_hash.delete('J')
  end

  return FIVE_OF_A_KIND if hand_hash.length == 1
  return HIGH_CARD if hand_hash.length == 5
  return ONE_PAIR if hand_hash.length == 4
  return TWO_PAIRS if hand_hash.length == 3 && hand_hash.value?(2)
  return THREE_OF_A_KIND if hand_hash.length == 3 && hand_hash.value?(3)
  return FOUR_OF_A_KIND if hand_hash.length == 2 && (hand_hash.values[0] == 1 || hand_hash.values[0] == 4)
  return FULL_HOUSE if hand_hash.length == 2 && (hand_hash.values[0] == 2 || hand_hash.values[0] == 3)

  'ERROR'
end

def largest_hash_key(hash)
  hash.max_by { |_, v| v }
end

def first_hand_stronger?(first_hand, second_hand)
  first_hand_type = get_hand_type(first_hand)
  second_hand_type = get_hand_type(second_hand)
  if first_hand_type > second_hand_type
    return true
  elsif first_hand_type < second_hand_type
    return false
  else
    (0..4).to_a.each do |card_index|
      if CARD_VALUE[first_hand[card_index]] > CARD_VALUE[second_hand[card_index]]
        return true
      elsif CARD_VALUE[first_hand[card_index]] < CARD_VALUE[second_hand[card_index]]
        return false
      end
    end
  end

  false
end

def main(input_file)
  sorted_hands = []
  File.readlines(input_file, chomp: true).each do |line|
    hand, bid = line.split(' ')
    bid = bid.to_i

    # p hand, get_hand_type(hand)
    if sorted_hands.empty?
      sorted_hands << line
    else
      sorted_hands.each_with_index do |sorted_hand, index|
        if first_hand_stronger?(sorted_hand.split(' ')[0], hand)
          sorted_hands.insert(index, *line)
          break
        elsif index == sorted_hands.length - 1
          sorted_hands << line
          break
        end
      end
    end
  end

  total = 0
  sorted_hands.each_with_index do |hand, index|
    total += hand.split(' ')[1].to_i * (index + 1)
  end
  p total
end

main(INPUT_FILE_PATH_TEST)
main(INPUT_FILE_PATH)
