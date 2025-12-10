# frozen_string_literal: true

test_parameter = ARGV.first
is_test_mode_enabled = ['-t', '--test'].include?(test_parameter)
filepath = "./2025/puzzle_inputs/day_8/full_input_day_8#{'_test' if is_test_mode_enabled}.txt"
puzzle_input = File.readlines(filepath, chomp: true)

class Box
  attr_reader :x, :y, :z
  attr_accessor :circuit_id

  def initialize(array_box)
    @x = array_box[0]
    @y = array_box[1]
    @z = array_box[2]
    @circuit_id = nil
  end

  def inspect
    "Box[#{@x}, #{@y}, #{@z}]"
  end

  def equals?(box)
    @x == box.x && @y == box.y && @z == box.z
  end
end

def distance(box_1, box_2)
  ((box_1.x - box_2.x)**2) + ((box_1.y - box_2.y)**2) + ((box_1.z - box_2.z)**2)
end

def boxes_in_same_circuits?(candidates)
  candidates[0].circuit_id == candidates[1].circuit_id && !candidates[0].circuit_id.nil?
end

def merge_box_circuits(circuits, candidates)
  new_circuit = circuits.dup
  circuit_id1 = candidates[0].circuit_id
  circuit_id2 = candidates[1].circuit_id
  circuits[circuit_id2].each do |box|
    box.circuit_id = circuit_id1
  end

  new_circuit[circuit_id1] = circuits[circuit_id1] + circuits[circuit_id2]
  new_circuit.delete(circuit_id2)
  new_circuit
end

boxes = []
puzzle_input.each do |line|
  boxes << Box.new(line.split(',').map(&:to_i))
end

all_distances = []
(0..(boxes.length - 2)).each do |index_box1|
  ((index_box1 + 1)..(boxes.length - 1)).each do |index_box2|
    box1 = boxes[index_box1]
    box2 = boxes[index_box2]

    all_distances << [distance(box1, box2), box1, box2]
  end
end
all_distances.sort_by!(&:first)

circuits = {}
connection_attempts = 0
next_circuit_id = 0
all_distances.each do |distance, box1, box2|
  limit = is_test_mode_enabled ? 10 : 1000
  break unless connection_attempts < limit

  connection_attempts += 1
  next if boxes_in_same_circuits?([box1, box2])

  if box1.circuit_id.nil? && box2.circuit_id.nil? # both are not in circuits
    box1.circuit_id = next_circuit_id
    box2.circuit_id = next_circuit_id
    circuits[next_circuit_id] = [box1, box2]
    next_circuit_id += 1
  elsif box1.circuit_id.nil? || box2.circuit_id.nil? # one of them is in a circuit
    binding.irb unless circuits.keys.include?(box1.circuit_id) || circuits.keys.include?(box2.circuit_id)
    circuits[box1.circuit_id.nil? ? box2.circuit_id : box1.circuit_id] << (box1.circuit_id.nil? ? box1 : box2)
    box1.circuit_id = box2.circuit_id if box1.circuit_id.nil?
    box2.circuit_id = box1.circuit_id if box2.circuit_id.nil?
  else # both are in different circuits
    circuits = merge_box_circuits(circuits, [box1, box2])
  end
end

circuits_sizes = []
circuits.each do |id, circuit|
  circuits_sizes << circuit.length
end

total = 1
3.times do
  total *= circuits_sizes.delete_at(circuits_sizes.index(circuits_sizes.max))
end

p total
