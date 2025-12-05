require './get_puzzle_input'
require './env'

day = ARGV.first
user = ARGV.last

# grab + save puzzle input
get_puzzle_inputs(day)

# create folder for day
dir_name = "#{CURRENT_YEAR}/day_#{day}"
Dir.mkdir(dir_name) unless File.exist?(dir_name)

Dir.mkdir("#{dir_name}/#{user}") unless File.exist?("#{dir_name}/#{user}")

# create rb file
starting_string = <<~BOILERPLATE
  # frozen_string_literal: true

  puzzle_input = File.readlines('./#{CURRENT_YEAR}/puzzle_inputs/day_#{day}/full_input_day_#{day}_test.txt', chomp: true)
  # puzzle_input = File.readlines('./#{CURRENT_YEAR}/puzzle_inputs/day_#{day}/full_input_day_#{day}.txt', chomp: true)

  puzzle_input.each do |line|
    p line
  end
BOILERPLATE

File.open("#{dir_name}/#{user}/day_#{day}.rb", 'w') { |f| f.write(starting_string) }

# download puzzle description
scrap_puzzle_description(day, "#{dir_name}/puzzle.md")
