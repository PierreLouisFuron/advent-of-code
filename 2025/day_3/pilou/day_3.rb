# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_3/full_input_day_3_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_3/full_input_day_3.txt', chomp: true)

def get_max_and_index(bank)
  max_b = 0
  index = 0
  bank.each_with_index do |b, i|
    if b > max_b
      max_b = b
      index = i
    end
  end
  [max_b, index]
end

# PART 1
# def get_highest_joltage(bank, joltage_length)
#   bank = bank.chars.map(&:to_i)
#   first_battery, first_battery_index = get_max_and_index(bank[0..(bank.length - 2)])
#   second_battery, = get_max_and_index(bank[(first_battery_index + 1)..])
#   "#{first_battery}#{second_battery}".to_i
# end

# PART 2 - that also works with part 1 if joltage_length == 2
def get_highest_joltage(bank, joltage_length)
  bank = bank.chars.map(&:to_i)
  batteries = []
  current_index = 0
  (0..(joltage_length - 1)).each do |j_index|
    battery, battery_index = get_max_and_index(bank[current_index..bank.length - joltage_length + j_index])
    batteries << battery
    current_index += battery_index + 1
  end
  batteries.join.to_i
end

total = 0
puzzle_input.each do |bank|
  total += get_highest_joltage(bank, 12)
end

p "total = #{total}"
