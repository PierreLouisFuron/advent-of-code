# Advent Of Code

Ruby repo to quickly pull puzzle inputs and share solutions for [Advent of Code](https://adventofcode.com/).

## Usage:

1. Create a `env.rb` file and set following values : 
    1. CURRENT_YEAR constant (like `CURRENT_YEAR=2024`)
    2. `SESSION_COOKIE` constant
    3. Your `USERNAME`
2. Copy the session cookie value from your AOC account as a string.
`SESSION_COOKIE = 'session=XXXXXXXX'`
3. Run `ruby prep_day.rb [DAY]` (Set the day + username yourself) to generate :
    - the daily puzzle description
    - the test input
    - your puzzle input
    - challenge files
4. Run `ruby get_puzzle [DAY]` to update the puzzle description when the second part has been unlocked.
