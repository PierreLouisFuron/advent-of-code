# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_2/full_input_day_2_test.txt', chomp: true).first
puzzle_input = File.readlines('./2025/puzzle_inputs/day_2/full_input_day_2.txt', chomp: true).first

# PART 1
# def is_invalid?(pattern)
#   pattern_length = pattern.length
#   if pattern_length.even?
#     left = pattern[0, pattern.length / 2].to_s
#     right = pattern[pattern.length / 2..].to_s
#     return true if left == right
#   end
#   false
# end

# PART 2
def is_invalid?(pattern)
  pattern_length = pattern.length
  if pattern_length.even?
    left = pattern[0, pattern.length / 2].to_s
    right = pattern[pattern.length / 2..].to_s
    return true if left == right
  end
  false
end

def invalids(range)
  total = 0
  (range[0]..range[1]).each do |combination|
    total += combination.to_i if is_invalid?(combination)
  end
  total
end

total = 0
ranges = puzzle_input.split(',').map { |n| n.split('-') }
ranges.each do |range|
  total += invalids(range)
end
p total

# p is_invalid?('11')
# p is_invalid?('446446')
# p is_invalid?('446447')

# puzzle_input.each do |line|
#   p line
# end
