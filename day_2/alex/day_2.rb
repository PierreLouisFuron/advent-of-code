puzzle_input = File.read('./puzzle_inputs/day_2/full_input_day_2.txt').lines


# Challenge 1:
# The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?

RED_CUBES_NO = 12
GREEN_CUBES_NO = 13
BLUE_CUBES_NO = 14

possible_game_ids = []

puzzle_input.each do |line|
  game_id = line.match(/\d+/)[0]

  %w[green red blue].each do |colour|
    instance_variable_set("@#{colour}_counts", line.scan(/(\d+) #{colour}/).flatten.map(&:to_i))
  end

  next if @blue_counts.max() > BLUE_CUBES_NO || @green_counts.max() > GREEN_CUBES_NO || @red_counts.max() > RED_CUBES_NO

  possible_game_ids << game_id.to_i
end

# answer = 2331
p possible_game_ids.sum
