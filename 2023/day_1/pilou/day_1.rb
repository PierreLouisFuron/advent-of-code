
# require './get_puzzle_input.rb'

INPUT_FILE_PATH = 'puzzle_inputs/day_1/full_input_day_1.txt'

REGEXP=[/\d/,'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

def find_first_and_last_digits(input_string)
    matches = input_string.scan(/\d|#{NUMBERS.join('|')}/)
    # first_digit = input_string[/\d/]
    # last_digit = input_string.reverse[/\d/]
    first_digit = matches.first
    if NUMBERS.index(first_digit)
        first_digit = NUMBERS.index(first_digit) + 1
    end
    last_digit = matches.last
    if NUMBERS.index(last_digit)
        last_digit = NUMBERS.index(last_digit) + 1
    end
    output="#{first_digit}#{last_digit}"
end

def read_input_file(file_path)
    total = 0
    total_2 = 0
    lines = File.read(file_path).split("\n")
    lines.each do |line|
        # total += find_first_and_last_digits(line).to_i
        total_2 += find_first_and_last_string_digits(line).to_i
    end
    # p total
    p total_2
end


def find_first_and_last_string_digits(input_string)
    first_digit = ''
    last_digit = ''
    first_position = nil
    last_position = nil
    REGEXP.each_with_index do |regexp, index|
        positions = input_string.enum_for(:scan, regexp).map { Regexp.last_match.begin(0) }

        if positions.any?
            if first_position.nil? || first_position > positions.first
                first_position = positions.first
                if index == 0
                    first_digit = input_string[first_position]
                else
                    first_digit = REGEXP.index(regexp)
                end
            end
            if last_position.nil? || last_position < positions.last
                last_position = positions.last
                if index == 0
                    last_digit = input_string[last_position]
                else
                    last_digit = REGEXP.index(regexp)
                end
            end
        end
    end
    output="#{first_digit}#{last_digit}"
end

  
read_input_file(INPUT_FILE_PATH)
