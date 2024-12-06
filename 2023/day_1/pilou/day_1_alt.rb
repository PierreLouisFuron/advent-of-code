
INPUT_FILE_PATH = 'puzzle_inputs/day_1/full_input_day_1.txt'

NUMBERS=['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

def read_input_file(file_path)
    total = 0
    total_2 = 0
    lines = File.read(file_path).split("\n")
    lines.each do |line|
        # total += find_first_and_last_digits(line).to_i
        total_2 += do_the_magick(line)
        
    end
    # p total
    p total_2
end

def do_the_magick(line)
    scanned_numbers = line.scan(/(?=(\d{1}|one|two|three|four|five|six|seven|eight|nine))/).flatten
    first = scanned_numbers.first
    first = NUMBERS.index(first) + 1 unless NUMBERS.index(first).nil?
    last = scanned_numbers.last
    last = NUMBERS.index(last) + 1 unless NUMBERS.index(last).nil?   
    "#{first}#{last}".to_i
end
  
read_input_file(INPUT_FILE_PATH)
