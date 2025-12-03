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

def get_highest_joltage(bank)
  bank = bank.chars.map { |e| e.to_i }
  first_battery, first_battery_index = get_max_and_index(bank[0..(bank.length - 2)])
  second_battery, second_battery_index = get_max_and_index(bank[(first_battery_index + 1)..])
  "#{first_battery}#{second_battery}".to_i
end

total = 0
puzzle_input.each do |bank|
  total += get_highest_joltage(bank)
end

p "total = #{total}"
