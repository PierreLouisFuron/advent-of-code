# frozen_string_literal: true

test_parameter = ARGV.first
is_test_mode_enabled = ['-t', '--test'].include?(test_parameter)
filepath = "./2025/puzzle_inputs/day_9/full_input_day_9#{'_test' if is_test_mode_enabled}.txt"
puzzle_input = File.readlines(filepath, chomp: true)

tiles = puzzle_input.map { |line| line.split(',').map(&:to_i) }

def calculate_area(t1, t2)
  ((t1[0] - t2[0]).abs + 1) * ((t1[1] - t2[1]).abs + 1)
end

# ============ PART 1 ============
part1_answer = tiles.combination(2).map { |t1, t2| calculate_area(t1, t2) }.max
puts "Part 1: #{part1_answer}"

# ============ PART 2 ============
# Build polygon edges with min/max for efficient lookup
HORIZONTAL_EDGES = [] # [y, x_min, x_max]
VERTICAL_EDGES = []   # [x, y_min, y_max]

(tiles + [tiles.first]).each_cons(2) do |(x1, y1), (x2, y2)|
  if y1 == y2
    HORIZONTAL_EDGES << [y1, [x1, x2].min, [x1, x2].max]
  else
    VERTICAL_EDGES << [x1, [y1, y2].min, [y1, y2].max]
  end
end

# Get polygon bounding box for quick rejection
POLY_MIN_X = tiles.map(&:first).min
POLY_MAX_X = tiles.map(&:first).max
POLY_MIN_Y = tiles.map(&:last).min
POLY_MAX_Y = tiles.map(&:last).max

# Check if point is on polygon boundary
def on_boundary?(x, y)
  HORIZONTAL_EDGES.any? { |ey, ex_min, ex_max| y == ey && x >= ex_min && x <= ex_max } ||
    VERTICAL_EDGES.any? { |ex, ey_min, ey_max| x == ex && y >= ey_min && y <= ey_max }
end

# Check if point is inside polygon using ray casting (with float division)
def inside_polygon?(x, y, tiles)
  inside = false
  (tiles + [tiles.first]).each_cons(2) do |(x1, y1), (x2, y2)|
    next if y1 == y2 # skip horizontal edges

    if ((y1 > y) != (y2 > y)) && (x < ((x2 - x1).to_f * (y - y1) / (y2 - y1)) + x1)
      inside = !inside
    end
  end
  inside
end

def point_valid?(x, y, tiles)
  on_boundary?(x, y) || inside_polygon?(x, y, tiles)
end

# Check if a horizontal segment [x_min, x_max] at y is fully inside polygon
# Strategy: find all x-coordinates where status changes, check intervals
def horizontal_segment_valid?(x_min, x_max, y, tiles)
  # Quick check: if segment is outside polygon bbox, reject unless on boundary
  return false if y < POLY_MIN_Y || y > POLY_MAX_Y
  return false if x_max < POLY_MIN_X || x_min > POLY_MAX_X

  # Find all critical x points in range: polygon vertices and edge intersections
  critical_xs = Set.new([x_min, x_max])

  # Add x-coords of polygon vertices on this y line
  tiles.each { |tx, ty| critical_xs << tx if ty == y && tx >= x_min && tx <= x_max }

  # Add intersections of vertical edges with this horizontal line
  VERTICAL_EDGES.each do |ex, ey_min, ey_max|
    critical_xs << ex if y >= ey_min && y <= ey_max && ex >= x_min && ex <= x_max
  end

  # Check endpoints and all critical points
  sorted_xs = critical_xs.sort
  sorted_xs.each do |x|
    return false unless point_valid?(x, y, tiles)
  end

  # Check midpoints between consecutive critical points
  sorted_xs.each_cons(2) do |xa, xb|
    mid_x = (xa + xb) / 2
    return false unless point_valid?(mid_x, y, tiles)
  end

  true
end

# Check if a vertical segment [y_min, y_max] at x is fully inside polygon
def vertical_segment_valid?(x, y_min, y_max, tiles)
  return false if x < POLY_MIN_X || x > POLY_MAX_X
  return false if y_max < POLY_MIN_Y || y_min > POLY_MAX_Y

  critical_ys = Set.new([y_min, y_max])

  # Add y-coords of polygon vertices on this x line
  tiles.each { |tx, ty| critical_ys << ty if tx == x && ty >= y_min && ty <= y_max }

  # Add intersections of horizontal edges with this vertical line
  HORIZONTAL_EDGES.each do |ey, ex_min, ex_max|
    critical_ys << ey if x >= ex_min && x <= ex_max && ey >= y_min && ey <= y_max
  end

  sorted_ys = critical_ys.sort
  sorted_ys.each do |y|
    return false unless point_valid?(x, y, tiles)
  end

  sorted_ys.each_cons(2) do |ya, yb|
    mid_y = (ya + yb) / 2
    return false unless point_valid?(x, mid_y, tiles)
  end

  true
end

# Check rectangle perimeter using segment validation (much faster)
def rectangle_valid?(t1, t2, tiles)
  min_x, max_x = [t1[0], t2[0]].minmax
  min_y, max_y = [t1[1], t2[1]].minmax

  # Check all 4 edges as segments
  return false unless horizontal_segment_valid?(min_x, max_x, min_y, tiles)
  return false unless horizontal_segment_valid?(min_x, max_x, max_y, tiles)
  return false unless vertical_segment_valid?(min_x, min_y, max_y, tiles)
  return false unless vertical_segment_valid?(max_x, min_y, max_y, tiles)

  true
end

# Sort pairs by area descending for early exit
pairs = tiles.combination(2).to_a
pairs.sort_by! { |t1, t2| -calculate_area(t1, t2) }

part2_answer = 0
checked = 0
pairs.each do |t1, t2|
  area = calculate_area(t1, t2)
  break if area <= part2_answer

  checked += 1
  puts "Checking #{checked}/#{pairs.length} (area=#{area})" if checked % 1000 == 0

  if rectangle_valid?(t1, t2, tiles)
    part2_answer = area
    puts "Found valid rectangle with area #{area}, t1: #{t1}, t2: #{t2}"
    break
  end
end

puts "Part 2: #{part2_answer}"
