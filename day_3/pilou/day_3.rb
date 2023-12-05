# Add up all the part numbers in the engine schematic
# Any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum. (Periods (.) do not count as a symbol.)
# Here is an example engine schematic:
# 467..114..
# ...*......
# ..35..633.
# ......#...
# 617*......
# .....+.58.
# ..592.....
# ......755.
# ...$.*....
# .664.598..
# In this schematic, two numbers are not part numbers because they are not adjacent to a symbol: 114 (top right) and 58 (middle right). 
# Every other number is adjacent to a symbol and so is a part number; their sum is 4361.
# What is the sum of all of the part numbers in the engine schematic?

DAY = 3
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt"
INPUT_FILE_PATH_TEST = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test.txt"

def load_schematic(file_path)
    schematic = []
    File.read(file_path).split("\n").each do |line|
        schematic << line
    end
    schematic
end

def get_pair_numbers(match, schematic, row_index)
    min_row_index = row_index == 0 ? row_index : row_index-1
    max_row_index = row_index == schematic[0].length-1 ? row_index : row_index+1
    min_col_index = match.begin(0) == 0 ? match.begin(0) : match.begin(0)-1
    max_col_index = match.end(0) == schematic.length-1 ? match.end(0)-1 : match.end(0)
    (min_row_index..max_row_index).each do |current_row_index|
        substring = schematic[current_row_index].slice(min_col_index, max_col_index - min_col_index + 1)
        spec_char_position = substring =~ /[^0-9.]/
        unless spec_char_position.nil?
            return ["#{spec_char_position + min_col_index}|#{current_row_index}|#{substring[spec_char_position]}", match[0].to_i]
        end
    end
    nil
end

def main(input_file_path)
    pair_numbers = {}
    schematic = load_schematic(input_file_path)
    schematic.each_with_index do |line, index|
        matches = line.enum_for(:scan, /\d+/).map { Regexp.last_match }
        matches.each do |match|
            pair_number = get_pair_numbers(match, schematic, index)
            unless pair_number.nil?
                pair_numbers[pair_number[0]] = []  unless pair_numbers.key?(pair_number[0])
                pair_numbers[pair_number[0]] << pair_number[1]
            end
        end
    end
    
    total_1 = total_2 = 0
    pair_numbers.each do |key, numbers|
        numbers.each do |nmb|
            total_1 += nmb
        end
        if key.split('|')[2] == '*' && numbers.length == 2
            total_2 += numbers[0] * numbers[1]
        end
    end
    p total_1
    p total_2
end

# main(INPUT_FILE_PATH_TEST)
main(INPUT_FILE_PATH)
