# frozen_string_literal: true

DAY = 4
INPUT_FILE_PATH = "../../puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt".freeze
INPUT_FILE_PATH_TEST = "../../puzzle_inputs/day_#{DAY}/small_input_day_#{DAY}.txt".freeze

WORD = 'XMAS'
puzzle = []
MS = %w[M S]

def mas_word?(position, puzzle)
  # p position

  unless MS.include?(puzzle[position[1] + 1][position[0] + 1]) && MS.include?(puzzle[position[1] - 1][position[0] - 1]) && puzzle[position[1] + 1][position[0] + 1] != puzzle[position[1] - 1][position[0] - 1]
    return false
  end

  unless MS.include?(puzzle[position[1] - 1][position[0] + 1]) && MS.include?(puzzle[position[1] + 1][position[0] - 1]) && puzzle[position[1] - 1][position[0] + 1] != puzzle[position[1] + 1][position[0] - 1]
    return false
  end

  # [-1, 1].each do |dir_x|
  #   [-1, 1].each do |dir_y|
  #     new_x = position[0] + dir_x
  #     new_y = position[1] + dir_y
  #     return false if out_of_bounds?([new_x, new_y], puzzle)

  #     p "position : #{position}, dir x/y : #{dir_x}/#{dir_y}, letter: #{puzzle[new_y][new_x]}"
  #     return false if dir_x == -1 && puzzle[new_y][new_x] != 'M'
  #     return false if dir_x == 1 && puzzle[new_y][new_x] != 'S'
  #   end
  # end
  # p position
  true
end

def xmas_word?(direction, position, index_letter, puzzle)
  new_x = position[0] + direction[0]
  new_y = position[1] + direction[1]
  return false if out_of_bounds?([new_x, new_y], puzzle) || WORD[index_letter] != puzzle[new_y][new_x]

  return true if puzzle[new_y][new_x] == WORD[index_letter] && index_letter == WORD.length - 1

  xmas_word?(direction, [new_x, new_y], index_letter + 1, puzzle)
end

def out_of_bounds?(position, puzzle)
  if position[0].negative? || position[0] > puzzle[0].length - 1 || position[1].negative? || position[1] > puzzle.length - 1
    return true
  end

  false
end

total = 0
puzzle_input = File.readlines(INPUT_FILE_PATH, chomp: true)
puzzle_input.each do |line|
  puzzle << line.chars
end

puzzle.each_with_index do |line, y|
  line.each_with_index do |value, x|
    # p "#{x},#{y}"
    # next unless value == 'X'
    next unless value == 'A'

    total += 1 if x.positive? && y.positive? && x < puzzle[0].length - 1 && y < puzzle.length - 1 && mas_word?([x, y],
                                                                                                               puzzle)

    # (-1..1).each do |next_x|
    #   (-1..1).each do |next_y|
    #     # if xmas_word?([next_x, next_y], [x, y], 1, puzzle)
    #     if mas_word?([next_x, next_y], [x, y], 1, puzzle)
    #       total += 1
    #       p 'found one'
    #     end
    #   end
    # end
  end
end

p total
