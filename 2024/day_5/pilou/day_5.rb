# frozen_string_literal: true

DAY = 5
INPUT_FILE_PATH = "../../puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt".freeze
INPUT_FILE_PATH_TEST = "../../puzzle_inputs/day_#{DAY}/small_input_day_#{DAY}.txt".freeze

rules = {}
# updates = []
total = 0

def ordered?(update, rules)
  (1..update.length - 1).each do |index|
    (0..index - 1).each do |previous_index|
      return false if rules.keys.include?(update[index]) && rules[update[index]].include?(update[previous_index])
    end
  end
  true
end

def order(update, rules)
  is_update_ordered = true
  (1..update.length - 1).each do |index|
    (0..index - 1).each do |previous_index|
      next unless rules.keys.include?(update[index]) && rules[update[index]].include?(update[previous_index])

      is_update_ordered = false
      tmp = update.delete_at(index)
      update.insert(previous_index, tmp)
      index = previous_index
      break
    end
  end
  if is_update_ordered
    ['0']
  else
    # p update
    update
  end
end

puzzle_input = File.readlines(INPUT_FILE_PATH, chomp: true)
puzzle_input.each do |line|
  if line.include?('|')
    first_page, seconde_page = line.split('|')
    rules[first_page] = [] unless rules.keys.include?(first_page)
    rules[first_page] << seconde_page
  elsif line.include?(',')
    update = line.split(',')
    # total += update[update.length / 2].to_i if ordered?(update, rules)
    ordered_update = order(update, rules)
    # p ordered_update
    total += ordered_update[ordered_update.length / 2].to_i
  end
  # p rules
  # p line
end

p total
