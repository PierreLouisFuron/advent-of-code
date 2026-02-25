# frozen_string_literal: true

test_parameter = ARGV.first
is_test_mode_enabled = ['-t', '--test'].include?(test_parameter)
filepath = "./2025/puzzle_inputs/day_9/full_input_day_9#{'_test' if is_test_mode_enabled}.txt"
puzzle_input = File.readlines(filepath, chomp: true)

def calculate_area(tile1, tile2)
  (tile1[0] - tile2[0] + 1).abs * (tile1[1] - tile2[1] + 1).abs
end

def print_grid(grid)
  grid.each do |line|
    p line.join
  end
end

def draw_line(grid, position1, position2)
  ([position2[1], position1[1]].min..[position2[1], position1[1]].max).each do |y|
    ([position2[0], position1[0]].min..[position2[0], position1[0]].max).each do |x|
      grid[y][x] = '#'
    end
  end
  grid
end

def tile_in_polygon?(tile, polygon)
  x, y = tile
  inside = false

  polygon.each_cons(2) do |(x1, y1), (x2, y2)|
    # Ray casting algorithm
    inside = !inside if ((y1 > y) != (y2 > y)) && (x < ((x2 - x1) * (y - y1) / (y2 - y1)) + x1)
  end

  # Don't forget to close the polygon (last -> first)
  x1, y1 = polygon.last
  x2, y2 = polygon.first
  inside = !inside if ((y1 > y) != (y2 > y)) && (x < ((x2 - x1) * (y - y1) / (y2 - y1)) + x1)

  inside
end

def tile_on_polygon?(tile, polygon)
  x, y = tile

  # Check each edge of the polygon
  (polygon + [polygon.first]).each_cons(2) do |(x1, y1), (x2, y2)|
    # Check if point is on this segment
    if x1 == x2 # vertical segment
      return true if x == x1 && y.between?(*[y1, y2].minmax)
    elsif y1 == y2 # horizontal segment
      return true if y == y1 && x.between?(*[x1, x2].minmax)
    end
  end

  false
end

# def rectangle_valid?(t1, t2, polygon)
#   get_rectangle(t1, t2).all? { |tile| tile_in_polygon?(tile, polygon) || tile_on_polygon?(tile, polygon) }
#   # get_rectangle(t1, t2).each do |tile|
#   #   return false unless tile_in_polygon?(tile, polygon) || tile_on_polygon(tile, polygon)
#   # end
#   # true
# end

def tile_valid?(tile, polygon)
  tile_in_polygon?(tile, polygon) || tile_on_polygon?(tile, polygon)
end

def rectangle_valid?(t1, t2, polygon)
  min_x, max_x = [t1[0], t2[0]].minmax
  min_y, max_y = [t1[1], t2[1]].minmax

  # Check top and bottom edges
  (min_x..max_x).each do |x|
    return false unless tile_valid?([x, min_y], polygon)
    return false unless tile_valid?([x, max_y], polygon)
  end

  # Check left and right edges (skip corners, already checked)
  ((min_y + 1)..(max_y - 1)).each do |y|
    return false unless tile_valid?([min_x, y], polygon)
    return false unless tile_valid?([max_x, y], polygon)
  end

  true
end

tiles = []
puzzle_input.each do |line|
  tiles << line.split(',').map(&:to_i)
end

# PART 1
# largest_area = 0
# (0..(tiles.length - 2)).each do |index_tile1|
#   (index_tile1..(tiles.length - 1)).each do |index_tile2|
#     tile1 = tiles[index_tile1]
#     tile2 = tiles[index_tile2]
#     area = calculate_area(tile1, tile2)
#     largest_area = area if area > largest_area
#   end
# end

# PART 2
# binding.irb
largest_area = 0
current_index = 0
rectangles = []
(0..(tiles.length - 2)).each do |index_tile1|
  (index_tile1..(tiles.length - 1)).each do |index_tile2|
    current_index += 1
    # p "attempt #{current_index}/245520"
    tile1 = tiles[index_tile1]
    tile2 = tiles[index_tile2]
    # next unless rectangle_valid?(tile1, tile2, tiles)
    rectangles << [calculate_area(tile1, tile2), tile1, tile2]
    # largest_area = area if area > largest_area
  end
end

rectangles.sort_by!(&:first).reverse!
# (0..[rectangles.length - 1, 1000].min).each do |index|
rectangles.each do |rec|
  largest_area, tile1, tile2 = rec
  p rectangles[index], index if largest_area == 1_568_849_600
  # break if rectangle_valid?(tile1, tile2, tiles)
end

# p get_rectangle([9, 5], [2, 3])
#  and
p rectangle_valid?([5601, 67_730], [94_800, 50_143], tiles)

# p tiles
# p calculate_area([2, 5], [11, 1])
p largest_area

# PART 2 - first attempt but not optimized
#
# grid = []
# (0..tiles.map(&:last).max + 1).each do |y|
#   grid << Array.new(tiles.map(&:first).max + 1, '.')
#   # (0..tiles.map(&:first)).each do |x|
#   # end
# end
# first_tile = []
# previous_tile = []
# tiles.each_with_index do |tile, index|
#   if index == 0
#     first_tile = tile
#     previous_tile = tile
#   elsif index != (tiles.length - 1)
#     grid = draw_line(grid, previous_tile, tile)
#     previous_tile = tile
#   else
#     grid = draw_line(grid, previous_tile, tile)
#     grid = draw_line(grid, tile, first_tile)
#   end
# end
#
# print_grid(grid)

# Store the rectangle and area in a list and sort and then check wich one is valid
