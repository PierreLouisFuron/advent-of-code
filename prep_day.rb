require './get_puzzle_input'

day = ARGV.first
user = ARGV.last

# grab + save puzzle input
get_puzzle_input(day)

# create folder for day
dir_name = "day_#{day}"
Dir.mkdir(dir_name) unless File.exist?(dir_name)

Dir.mkdir("#{dir_name}/#{user}") unless File.exist?("#{dir_name}/#{user}")

# create rb file
starting_string = <<-BOILERPLATE
# frozen_string_literal: true

puzzle_input = File.readlines('./puzzle_inputs/day_#{day}/full_input_day_#{day}.txt', chomp: true)
puzzle_input.each do |line|
  p line
end
BOILERPLATE

File.open("#{dir_name}/#{user}/day_#{day}.rb", 'w') { |f| f.write(starting_string) }
