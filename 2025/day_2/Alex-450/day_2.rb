# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_2/full_input_day_2_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_2/full_input_day_2.txt', chomp: true)

invalid_ids = 0
puzzle_input.each do |line|
  ranges = line.split(',')
  ranges.each do |range|
    full_range = (range.split('-')[0].to_i..range.split('-')[1].to_i).to_a

    full_range.each do |id|
      length = id.to_s.length / 2
      halves = [id.to_s[0...id.to_s.length/2], id.to_s[id.to_s.length/2..]]
      if halves[0] == halves[1]
        invalid_ids += id
      end
    end
  end
end

puts "part 1: #{invalid_ids}"