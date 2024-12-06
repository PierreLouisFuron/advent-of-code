# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize

DAY = 8
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt".freeze
INPUT_FILE_PATH_TEST_1 = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test_1.txt".freeze
INPUT_FILE_PATH_TEST_2 = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test_2.txt".freeze
INPUT_FILE_PATH_TEST_3 = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test_3.txt".freeze

def go_to_next_position(position, direction, map)
  direction == 'L' ? map[position][0] : map[position][1]
end

def main(input_file)
  instructions, map = File.read(input_file, chomp: true).split("\n\n")
  map_hashmap = {}
  map.split("\n").each do |node|
    node = node.scan(/\w{3}/)
    map_hashmap[node[0]] = [node[1], node[2]]
  end
  # p map_hashmap

  # index = 0
  # current_position = 'AAA'
  # while current_position != 'ZZZ'
  #   direction = instructions[index % instructions.length]
  #   current_position = go_to_next_position(current_position, direction, map_hashmap)
  #   index += 1
  # end
  # p index

  starting_positions = map_hashmap.keys.select { |key| key.end_with?('A') }
  p starting_positions
  index = 0
  current_position = 'VKA' # ["PBA", "LSA", "VSA", "QVA", "AAA", "VKA"]
  while index < 1_000_000
    direction = instructions[index % instructions.length]
    p "#{index} - #{direction}" if current_position.end_with?('Z')
    current_position = go_to_next_position(current_position, direction, map_hashmap)
    index += 1
  end
  p index

  # index = 0
  # until starting_positions.all? { |str| str.end_with?('Z') }
  #   print '.' if index % 100_000.zero?
  #   direction = instructions[index % instructions.length]
  #   starting_positions = starting_positions.map { |position| go_to_next_position(position, direction, map_hashmap) }
  #   index += 1
  # end

  # p index
end

# main(INPUT_FILE_PATH_TEST_1)
# main(INPUT_FILE_PATH_TEST_2)
# main(INPUT_FILE_PATH_TEST_3)
main(INPUT_FILE_PATH)
