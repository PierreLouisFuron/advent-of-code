# frozen_string_literal: true

DAY = 10
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt".freeze
INPUT_FILE_PATH_TEST_1 = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test_1.txt".freeze
INPUT_FILE_PATH_TEST_2 = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test_2.txt".freeze

def display_maze(maze)
  maze.each do |line|
    p line.join
  end
  p ''
end

def can_i_go_up(current_position, maze)
  if current_position[0] > 0 && 'S|LJ'.include?(current_position[2]) && '|7F'.include?(maze[current_position[0]-1][current_position[1]])
    return [current_position[0]-1, current_position[1], maze[current_position[0]-1][current_position[1]]]
  end
  return false
end

def can_i_go_down(current_position, maze)
  if current_position[0] < maze.length-1 && 'S|7F'.include?(current_position[2]) && '|LJ'.include?(maze[current_position[0]+1][current_position[1]])
    return [current_position[0]+1, current_position[1], maze[current_position[0]+1][current_position[1]]]
  end
  return false
end

def can_i_go_left(current_position, maze)
  if current_position[1] > 0 && 'S-J7'.include?(current_position[2]) && '-FL'.include?(maze[current_position[0]][current_position[1]-1])
    return [current_position[0], current_position[1]-1, maze[current_position[0]][current_position[1]-1]]
  end
  return false
end

def can_i_go_right(current_position, maze)
  if current_position[1] < maze[0].length-1 && 'S-FL'.include?(current_position[2]) && '-J7'.include?(maze[current_position[0]][current_position[1]+1])
    return [current_position[0], current_position[1]+1, maze[current_position[0]][current_position[1]+1]]
  end
  return false
end

def main(input_file)
  maze = []
  positions = []
  File.readlines(input_file, chomp: true).each_with_index do |line, index|
    maze << line.split('')
    positions << [index, line.index('S'), 'S'] if line.index('S')
  end
  p positions
  index = 0
  until positions.empty?
    new_positions = []
    positions.each_with_index do |position, index|
      new_positions << can_i_go_up(position, maze) if can_i_go_up(position, maze)
      new_positions << can_i_go_down(position, maze) if can_i_go_down(position, maze)
      new_positions << can_i_go_left(position, maze) if can_i_go_left(position, maze)
      new_positions << can_i_go_right(position, maze) if can_i_go_right(position, maze)
      maze[position[0]][position[1]] = "#"
    end
    # display_maze(maze)
    p new_positions
    positions = new_positions
    index += 1
    break if index > 50
  end

  p index - 1
  # p can_i_go_down(starting_position, maze)
  # p can_i_go_left(starting_position, maze)
  # p can_i_go_right(starting_position, maze)
end

# main(INPUT_FILE_PATH_TEST_1)
# main(INPUT_FILE_PATH_TEST_2)
main(INPUT_FILE_PATH)
