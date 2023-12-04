# frozen_string_literal: true

puzzle_input = File.read('./puzzle_inputs/day_2/full_input_day_2.txt').lines

# Challenge 1:
# The Elf would first like to know which games would have been possible
# if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?

RED_CUBES_NO = 12
GREEN_CUBES_NO = 13
BLUE_CUBES_NO = 14

possible_game_ids = []

def max_game_counts(line)
  %w[green red blue].each do |colour|
    instance_variable_set("@#{colour}_max", line.scan(/(\d+) #{colour}/).flatten.map(&:to_i).max)
  end
end

puzzle_input.each do |line|
  game_id = line.match(/\d+/)[0]

  max_game_counts(line)

  next if @blue_max > BLUE_CUBES_NO || @green_max > GREEN_CUBES_NO || @red_max > RED_CUBES_NO

  possible_game_ids << game_id.to_i
end

# answer = 2331
print "Part 1 answer: #{possible_game_ids.sum}"

# Challenge 2
# The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together.
# The power of the minimum set of cubes in game 1 is 48. In games 2-5 it was 12, 1560, 630, and 36, respectively.
# Adding up these five powers produces the sum 2286.
# For each game, find the minimum set of cubes that must have been present. What is the sum of the power of these sets?

game_powers = []

puzzle_input.each do |line|
  max_game_counts(line)

  game_power = @green_max * @blue_max * @red_max

  game_powers << game_power
end

# answer = 71585
print "\n"
print "Part 2 answer: #{game_powers.sum}"
print "\n"
