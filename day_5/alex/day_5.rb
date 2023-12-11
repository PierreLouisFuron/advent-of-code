# frozen_string_literal: true

puzzle_input = File.readlines('./puzzle_inputs/day_5/full_input_day_5.txt', chomp: true)
sample_input = File.readlines('./puzzle_inputs/day_5/sample_input_day_5.txt', chomp: true)

def get_seed_numbers(input)
  input.first.scan(/(\d+)/).flatten
end

def get_seed_to_soil(input)
  start_index = input.find_index('seed-to-soil map:') + 1
  end_index = input.find_index('soil-to-fertilizer map:') - 1

  input[start_index..end_index].each do |line|
    next if line.empty?

    destination_range_start = line.scan(/\d+/).first.to_i
    source_range_start = line.scan(/\d+/)[1].to_i
    range_length = line.scan(/\d+/)[2].to_i
    source_range_end = source_range_start + range_length - 1
    destination_range_end = destination_range_start + range_length - 1
    source_range = (source_range_start..source_range_end)
    destination_range = (destination_range_start..destination_range_end)

    p source_range
    p destination_range
  end
end

seeds = get_seed_numbers(sample_input)

get_seed_to_soil(sample_input)
