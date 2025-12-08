require './get_puzzle_input'
require './env'

day = ARGV.first
dir_name = "#{CURRENT_YEAR}/day_#{day}"

scrape_puzzle_description(day, "#{dir_name}/puzzle.md")
