
INPUT_FILE_PATH = 'puzzle_inputs/day_2/full_input_day_2.txt'
RED_LIMIT = 12
GREEN_LIMIT = 13
BLUE_LIMIT = 14

COLORS = ['red', 'green', 'blue']
LIMITS = {
    'red'=> 12,
    'green'=> 13,
    'blue'=> 14
}

def read_input_file(file_path)
    games = File.read(file_path).split("\n")
    total = 0
    total_power = 0
    games.each_with_index do |game, index|
        is_game_possible, power = is_game_possible?(game.split(':')[1].split(';'))
        total += index + 1 if is_game_possible
        total_power += power
    end
    p "Possible games : #{total}"
    p "Total power : #{total_power}"
end

def is_game_possible?(game_sets)

    min_red_cubes = 0
    min_green_cubes = 0
    min_blue_cubes = 0
    is_game_possible = true
    game_sets.each do |game_set|
        game_set.split(',').each do |revealed_cubes|
            revealed_cubes = revealed_cubes.strip
            number, color = revealed_cubes.split(' ')
            number = number.to_i
            is_game_possible = false if number > LIMITS[color]

            min_red_cubes = number if (color == 'red' && number > min_red_cubes)
            min_green_cubes = number if (color == 'green' && number > min_green_cubes)
            min_blue_cubes = number if (color == 'blue' && number > min_blue_cubes)
        end
    end
    p game_sets
    p "#{min_red_cubes} red / #{min_green_cubes} green / #{min_blue_cubes} blue"
    [is_game_possible, min_red_cubes * min_green_cubes * min_blue_cubes]
end

read_input_file(INPUT_FILE_PATH)
