# frozen_string_literal: true

DAY = 1
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt"
INPUT_FILE_PATH_TEST = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test.txt"

# puzzle_input = File.readlines('small_input_day_1.txt', chomp: true)
puzzle_input = File.readlines('full_input_day_1.txt', chomp: true)
locations1 = []
locations2 = []
puzzle_input.each do |line|
  locations = line.split('   ')
  locations1 << locations[0].to_i
  locations2 << locations[1].to_i
end

locations1 = locations1.sort
locations2 = locations2.sort

total_sum = 0

(0..locations1.length - 1).each do |index|
  total_sum += (locations1[index] - locations2[index]).abs
end

p total_sum

counts = locations2.tally

sscore = 0
locations1.each do |e|
  sscore += e * counts[e].to_i
end

p sscore
