# frozen_string_literal: true

puzzle_input = File.readlines('./puzzle_inputs/day_8/full_input_day_8.txt', chomp: true)
# sample_input = File.readlines('./puzzle_inputs/day_8/sample_input_day_8.txt', chomp: true)
# sample_input2 = File.readlines('./puzzle_inputs/day_8/sample_input_day_8_2.txt', chomp: true)
sample_input_part_2 = File.readlines('./puzzle_inputs/day_8/sample_input_day_8_part_2.txt', chomp: true)

def get_instructions(input)
  input.first.split('') * 100_000 # hardcoded messy
end

def get_map(input)
  map = {}
  input[2..].map { |line| line.scan(/\w+/) }.each do |line|
    map[line[0]] = [line[1], line[2]]
  end
  map
end

def get_starting_point(network_map)
  network_map.select { |key, _value| key == 'AAA' }
end

def get_starting_points(network_map)
  network_map.select { |key, _value| key.split('').last == 'A' }
end

def final_destination?(starting_points)
  starting_points.map { |key, _value| key.split('').last == 'Z' }.uniq == [true]
end

def get_new_indexes(instruction, starting_points, network_map)
  if instruction == 'R'
    network_map.select { |key, _value| starting_points.values.map { |values| values[1] }.include?(key)  }
  else
    network_map.select { |key, _value| starting_points.values.map { |values| values[0] }.include?(key)  }
  end
end

def cycle_through_map_part1(starting_point, instructions, network_map)
  instructions.each_with_index do |instruction, instruction_index|
    destination = get_new_indexes(instruction, starting_point, network_map)

    return (instruction_index + 1) if destination.keys.first == 'ZZZ'

    starting_point = destination
  end
end

def calculate_total_steps(steps_array)
  steps_array.reduce(1) { |lcm, n| lcm.lcm(n) }
end

def final_step?(destination, steps_to_reach_end, instruction_index)
  destination.each do |line|
    if line.first.split('').last == 'Z'
      destination.delete(line.first)
      steps_to_reach_end << (instruction_index + 1)
    end
  end
end

def cycle_through_map_part2(starting_point, instructions, network_map)
  steps_to_reach_end = []
  instructions.each_with_index do |instruction, instruction_index|
    destination = get_new_indexes(instruction, starting_point, network_map)

    final_step?(destination, steps_to_reach_end, instruction_index)
    return calculate_total_steps(steps_to_reach_end) if destination.empty?

    starting_point = destination
  end
end

def get_answer_part1(input)
  network_map = get_map(input)
  instructions = get_instructions(input)
  starting_point = get_starting_point(network_map)
  cycle_through_map_part1(starting_point, instructions, network_map)
end

p1_answer = 24_253
total_steps = get_answer_part1(puzzle_input)

print 'Part 1 tests passed ✅' if total_steps == p1_answer
print "\n"

# Part 2

def get_answer_part2(input)
  network_map = get_map(input)
  instructions = get_instructions(input)
  starting_points = get_starting_points(network_map)
  cycle_through_map_part2(starting_points, instructions, network_map)
end

answer_part2 = get_answer_part2(puzzle_input)

p2_answer = 12_357_789_728_873
print 'Part 2 tests passed ✅' if p2_answer == answer_part2
print "\n"
