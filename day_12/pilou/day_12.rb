# frozen_string_literal: true

DAY = 12
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt".freeze
INPUT_FILE_PATH_TEST = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test.txt".freeze

def find_arrangements(input_string, test_criteria)
  arrangements = 0
  question_marks_count = input_string.count('?')
  # Generate all binary combinations of 0 and 1 with the same length as the number of "?"
  (0...(2**question_marks_count)).each do |i|
    binary_representation = i.to_s(2).rjust(question_marks_count, '0')
    possibility = input_string
    binary_representation.chars.each_with_index do |value, index|
      possibility = value == '0' ? possibility.sub('?', '.') : possibility.sub('?', '#')
    end
    # possibility.chars.each_with_index do |char, index|
    #   if
    #   possibility[index] = binary_representation[index] == '0' ? '.' : '#'
    # end

    arrangements += 1 if is_arrangement_possible?(possibility, test_criteria)
  end

  return arrangements
end

def is_arrangement_possible?(arrangement, test_criteria)

  arrangement = arrangement.split('.')
  arrangement.reject!(&:empty?)
  arrangement = arrangement.map{ |el| el.count('#')}
  return true if arrangement == test_criteria
  false

  # return true
  # # \.*#{1}\.+#{1}\.+#{3}\.*
  # test_criteria = test_criteria.map {|criteria| "#\{#{criteria}\}"}
  # # p test_criteria
  # regex_pattern = Regexp.new("#{test_criteria.join('\.+')}")
  # matches = arrangement.scan(regex_pattern)
  # p arrangement
  # if matches.length == 1 && matches[0].length == arrangement.length
  #   return true
  # elsif matches.length > 1
  #   p 'MAYDAAY !!!!!'
  # else
  #   return false
  # end
end

def main(input_file)

  # arrangements = find_arrangements('???.###', [1,1,3])
  # arrangements = find_arrangements('???.###????.###????.###????.###????.###', [1,1,3,1,1,3,1,1,3,1,1,3,1,1,3])
  arrangements = find_arrangements('.??..??...?##.?.??..??...?##.?.??..??...?##.?.??..??...?##.?.??..??...?##.', [1,1,3,1,1,3,1,1,3,1,1,3,1,1,3])
  p arrangements


  # total = 0
  # File.readlines(input_file, chomp: true).each do |springs_line|
  #   springs, size_of_each_contiguous_group_of_damaged_springs = springs_line.split(' ')
  #   size_of_each_contiguous_group_of_damaged_springs = size_of_each_contiguous_group_of_damaged_springs.split(',').map(&:to_i)
  #   possibilities = generate_possibilities(springs)
  #   # p possibilities

  #   current_total = 0

  #   possibilities.each do |possibility|
  #     # p possibility
  #     current_total += 1 if is_arrangement_possible?(possibility, size_of_each_contiguous_group_of_damaged_springs)
  #   end
  #   p "#{springs} - #{current_total}"
  #   total += current_total

  # end
  # p total

end

main(INPUT_FILE_PATH_TEST)
# main(INPUT_FILE_PATH)
