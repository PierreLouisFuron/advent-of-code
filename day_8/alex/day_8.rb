# frozen_string_literal: true

puzzle_input = File.readlines('./puzzle_inputs/day_8/full_input_day_8.txt', chomp: true)
sample_input = File.readlines('./puzzle_inputs/day_8/sample_input_day_8.txt', chomp: true)
sample_input2 = File.readlines('./puzzle_inputs/day_8/sample_input_day_8_2.txt', chomp: true)

def get_instructions(input)
  input.first.split('') * 1000 # hardcoded messy
end

def get_map(input)
  input[2..].map { |line| line.scan(/\w+/) }
end

def get_starting_index(network_map)
  network_map.find_index { |arr| arr.first == 'AAA' }
end

def cycle_through_map(destination_index, instructions, network_map)
  instructions.each_with_index do |instruction, instruction_index|
    destination = if instruction == 'R'
                    network_map[destination_index].last
                  else
                    network_map[destination_index][1]
                  end
    destination_index = network_map.find_index { |arr| arr.first == destination }

    return (instruction_index + 1) if destination == 'ZZZ'
  end
end

def get_answer_part1(input)
  network_map = get_map(input)
  instructions = get_instructions(input)
  starting_index = get_starting_index(network_map)
  cycle_through_map(starting_index, instructions, network_map)
end

# Answer p1 = 24253
total_steps = get_answer_part1(puzzle_input)

print "Answer part 1: #{total_steps}"
print "\n"
