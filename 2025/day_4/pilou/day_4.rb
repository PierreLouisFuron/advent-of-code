# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_4/full_input_day_4_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_4/full_input_day_4.txt', chomp: true)

def get_neighbours(grid, position)
  neighbours = []
  ([position[0] - 1,0].max..[position[0] + 1,(grid[0].length-1)].min).each do |x|
    ([position[1] - 1,0].max..[position[1] + 1,(grid.length-1)].min).each do |y|
      next if (x == position[0] && y == position[1])
        neighbours << grid[y][x]
    end
  end
  neighbours
end

def get_removable_rolls(grid)
  removable_rolls = []
  grid.each_with_index do |line, index_y|
    line.each_with_index do |pos, index_x|
      removable_rolls << [index_x, index_y] if get_neighbours(grid, [index_x,index_y]).count('@') < 4 && pos == '@'
    end
  end
  removable_rolls
end

grid = []
puzzle_input.each do |line|
  grid << line.chars
end

total = 0
# total = get_removable_rolls(grid).count # result for part 1
removable_rolls = [1]
while removable_rolls.count > 0
  removable_rolls = get_removable_rolls(grid)
  total += removable_rolls.count

  removable_rolls.each do |roll|
    grid[roll[1]][roll[0]] = '.'
  end
end

p "total : #{total}"
