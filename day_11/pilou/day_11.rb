# frozen_string_literal: true

DAY = 11
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt".freeze
INPUT_FILE_PATH_TEST = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test.txt".freeze

def display_star_chart(chart)
  chart.each do |line|
    line.each do |point|
      print point
    end
    p ''
  end
end

def expand_universe(chart, age)
  exp_col_indexes = [] #[2,5,8]
  (0..chart[0].length-1).to_a.each do |index|
    exp_col_indexes << index if chart.all? { |line| line[index] == '.'}
  end
  exp_line_indexes = [] #[3,7]
  chart.each_with_index do |line, index|
    exp_line_indexes << index unless line.include?('#')
  end

  galaxies = locate_galaxies(chart)

  older_galaxies = []
  galaxies.each do |galaxy|
    horizontal_expention_factor = exp_line_indexes.count { |element| element < galaxy[0] }
    vertical_expention_factor = exp_col_indexes.count { |element| element < galaxy[1] }
    older_galaxies << [galaxy[0] + age * horizontal_expention_factor, galaxy[1] + age * vertical_expention_factor]
  end

  older_galaxies
end

def locate_galaxies(chart)
  galaxies = []
  chart.each_with_index do |line, line_index|
    line.each_with_index do |element, el_index|
      galaxies << [line_index, el_index] if element == '#'
    end
  end
  galaxies
end

def distance(galaxy_1, galaxy_2)
  return (galaxy_1[0] - galaxy_2[0]).abs + (galaxy_1[1] - galaxy_2[1]).abs
end

def main(input_file)
  star_chart = []
  File.readlines(input_file, chomp: true).each do |line|
    star_chart << line.split('')
  end

  galaxies = expand_universe(star_chart, 999999)

  total = 0
  galaxies.each_with_index do |galaxy_1, index_1|
    galaxies.each_with_index do |galaxy_2, index_2|
      total += distance(galaxy_1, galaxy_2) unless index_1 == index_2
    end
  end

  p total/2
end

main(INPUT_FILE_PATH_TEST)
main(INPUT_FILE_PATH)
