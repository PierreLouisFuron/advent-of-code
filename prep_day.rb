require './get_puzzle_input'
require './env'

day = ARGV.first

# grab + save puzzle input
get_puzzle_inputs(day)

# create folder for day
dir_name = "#{CURRENT_YEAR}/day_#{day}"
Dir.mkdir(dir_name) unless File.exist?(dir_name)

Dir.mkdir("#{dir_name}/#{USERNAME}") unless File.exist?("#{dir_name}/#{USERNAME}")

# create rb file
starting_string = <<~BOILERPLATE
  # frozen_string_literal: true

  test_parameter = ARGV.first
  is_test_mode_enabled = ['-t', '--test'].include?(test_parameter)
  filepath = "./#{CURRENT_YEAR}/puzzle_inputs/day_#{day}/full_input_day_#{day}\#{'_test' if is_test_mode_enabled}.txt"
  puzzle_input = File.readlines(filepath, chomp: true)

  puzzle_input.each do |line|
    p line
  end
BOILERPLATE

File.write("#{dir_name}/#{USERNAME}/day_#{day}.rb", starting_string)

# download puzzle description
scrape_puzzle_description(day, "#{dir_name}/puzzle.md")
