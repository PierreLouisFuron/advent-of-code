# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_2/full_input_day_2_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_2/full_input_day_2.txt', chomp: true)


def get_full_range(range)
  start_val = range.split('-')[0].to_i
  end_val = range.split('-')[1].to_i
  (start_val..end_val)
end

def duplicated_id?(id)
  id = id.to_s

  halves = [id[0...id.length/2], id[id.length/2..]]

  halves[0] == halves[1]
end

# part 1
# answer = 18952700150
invalid_ids = 0
puzzle_input.each do |line|
  ranges = line.split(',')
  ranges.each do |range|
    full_range = get_full_range(range)

    full_range.each do |id|
      if duplicated_id?(id)
        invalid_ids += id
      end
    end
  end
end

puts "part 1: #{invalid_ids}"

# part 2
# answer = 28858486244

def split_number(num, parts)
  part_size = num.length / parts
  num.chars.each_slice(part_size).map { |chars| chars.join }
end

def id_repeats?(id)
  id = id.to_s
  (2..id.length.to_i).any? do |length|
    parts = split_number(id, length)
    parts && parts.uniq.length == 1
  end
end

invalid_ids = 0
puzzle_input.each do |line|
  ranges = line.split(',')
  ranges.each do |range|
    full_range = get_full_range(range)

    full_range.each do |id|
      invalid_ids += id if id_repeats?(id)
    end
  end
end

puts "part 2: #{invalid_ids}"