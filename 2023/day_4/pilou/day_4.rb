
DAY = 4
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt"
INPUT_FILE_PATH_TEST = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test.txt"

# def calculate_card_point(card)
#   card_point = 0
#   card = card.split(':')[1]
#   winning_numbers, owned_numbers = card.split('|')
#   winning_numbers = winning_numbers.split(' ').map(&:to_i)
#   owned_numbers = owned_numbers.split(' ').map(&:to_i)

#   owned_numbers.each do |owned_number|
#     if winning_numbers.include?(owned_number)
#       card_point = card_point == 0 ? card_point = 1 : card_point = card_point*2
#     end
#   end
#   p card_point
#   card_point
# end

# def main(input_file)
#   total = 0
#   cards = File.read(input_file).split("\n")
#   cards.each_with_index do |card, index|
#     total += calculate_card_point(card)
#   end
#   p total
# end

def main(input_file)
  total = 0
  cards = File.read(input_file).split("\n")
  earned_scrapcards = Array.new(cards.length, 1)
  cards.each_with_index do |card, index|
    card = card.split(':')[1]
    winning_numbers, owned_numbers = card.split('|')
    winning_numbers = winning_numbers.split(' ').map(&:to_i)
    owned_numbers = owned_numbers.split(' ').map(&:to_i)
  
    number_or_matching_numbers = 0
    owned_numbers.each do |owned_number|
      if winning_numbers.include?(owned_number)
        number_or_matching_numbers += 1
        earned_scrapcards[index + number_or_matching_numbers] += earned_scrapcards[index]
      end
    end
    p number_or_matching_numbers
  end

  total = 0
  earned_scrapcards.each do |nmb|
    total += nmb
  end
  p total
end

# main(INPUT_FILE_PATH_TEST)
main(INPUT_FILE_PATH)
