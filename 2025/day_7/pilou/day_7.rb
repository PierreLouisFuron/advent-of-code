# frozen_string_literal: true

puzzle_input = File.readlines('./2025/puzzle_inputs/day_7/full_input_day_7_test.txt', chomp: true)
# puzzle_input = File.readlines('./2025/puzzle_inputs/day_7/full_input_day_7.txt', chomp: true)

def get_starting_index(line)
  line.chars.each_with_index do |char, index|
    return index if char == 'S'
  end
end

def travel_light(line, beam_indexes)
  return [0, beam_indexes] if line.chars.uniq == ['.']

  split_beams_total = 0
  new_beam_indexes = []
  beam_indexes.each do |beam_index|
    if line[beam_index] == '^'
      split_beams_total += 1
      new_beam_indexes << [beam_index - 1, beam_index + 1]
    else
      new_beam_indexes << beam_index
    end
  end
  new_beam_indexes = new_beam_indexes.flatten.uniq
  [split_beams_total, new_beam_indexes]
end

beam_indexes = []

total = 0
puzzle_input.each_with_index do |line, index|
  if index == 0
    beam_indexes << get_starting_index(line)
  else
    split_beams_total, beam_indexes = travel_light(line, beam_indexes)
    total += split_beams_total
  end
end

p "total : #{total}"
