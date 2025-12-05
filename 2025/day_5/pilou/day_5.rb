# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_5/full_input_day_5_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_5/full_input_day_5.txt', chomp: true)

fresh_ingredients_ranges = []

def overlap?(range_1, range_2)
  range_1.cover?(range_2.begin) || range_2.cover?(range_1.begin)
end

def merge(r1, r2)
  ([r1.begin, r2.begin].min..[r1.end, r2.end].max)
end

def add_new_range(ranges, new_range)
  new_ranges = []
  ranges.each_with_index do |range, _index|
    if overlap?(range, new_range)
      new_range = merge(range, new_range) if overlap?(range, new_range)
    else
      new_ranges << range
    end
  end

  new_ranges << new_range
end

def fresh?(ranges, ingredient)
  ranges.each do |range|
    return true if range.include?(ingredient)
  end
  false
end

total = 0
fresh_ingredients = 0
puzzle_input.each do |line|
  if line.include?('-')
    line = line.split('-')
    new_range = (line[0].to_i..line[1].to_i)

    fresh_ingredients_ranges = add_new_range(fresh_ingredients_ranges, new_range)
  elsif fresh?(fresh_ingredients_ranges, line.to_i) && line != ''
    total += 1
  end
end

fresh_ingredients_ranges.each do |range|
  fresh_ingredients += range.size
end

p "total : #{total}"
p "total fresh ingredients: #{fresh_ingredients}"
