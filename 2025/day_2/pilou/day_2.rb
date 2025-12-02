# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_2/full_input_day_2_test.txt', chomp: true).first
puzzle_input = File.readlines('./2025/puzzle_inputs/day_2/full_input_day_2.txt', chomp: true).first

# PART 1
# def invalid?(pattern)
#   pattern_length = pattern.length
#   if pattern_length.even?
#     left = pattern[0, pattern.length / 2].to_s
#     right = pattern[pattern.length / 2..].to_s
#     return true if left == right
#   end
#   false
# end

# PART 2
def invalid?(pattern)
  pattern_length = pattern.length

  (1..pattern_length - 1).each do |sample_size|
    next unless (pattern_length % sample_size).zero?

    # split the string in equal parts of SAMPLE_SIZE size and then comparing if they're all equals
    combinations = pattern.scan(/.{#{sample_size}}/)
    return true if combinations.uniq == [combinations[0]]
  end
  false
end

def invalids(range)
  total = 0
  (range[0]..range[1]).each do |combination|
    total += combination.to_i if invalid?(combination)
  end
  total
end

total = 0
ranges = puzzle_input.split(',').map { |n| n.split('-') }
ranges.each do |range|
  total += invalids(range)
end
p total

# p invalid?('11') # expected output : true
# p invalid?('446446') # expected output : true
# p invalid?('446446446') # expected output : true
# p invalid?('446447446') # expected output : false
# p invalid?('446446447') # expected output : false
# p invalid?('446447') # expected output : false
