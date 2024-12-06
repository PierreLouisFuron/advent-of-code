# Advent Of Code

Ruby repo to quickly pull puzzle inputs and share solutions for [Advent of Code](https://adventofcode.com/).

## Usage:

1. Create a `env.rb` file and set two values : 
 1.1. a CURRENT_YEAR constant (like `CURRENT_YEAR=2024`)
 1.2. a `COOKIE` constant
2. Copy the cookie value from your AOC account as a string.
`SESSION_COOKIE = 'session=XXXXXXXX'`
3. To get your daily puzzle input and challenge files created run `ruby prep_day.rb [DAY] [USERNAME]` (Set the day + username yourself).
