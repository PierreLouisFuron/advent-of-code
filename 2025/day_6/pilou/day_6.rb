# frozen_string_literal: true

# puzzle_input = File.readlines('./2025/puzzle_inputs/day_6/full_input_day_6_test.txt', chomp: true)
puzzle_input = File.readlines('./2025/puzzle_inputs/day_6/full_input_day_6.txt', chomp: true)

def calculate_total(problems)
  total = 0
  problems.each do |problem|
    operation = problem[-1]
    local_total = operation == '+' ? 0 : 1
    problem[..-2].each do |number|
      if operation == '+'
        local_total += number
      elsif local_total *= number
      end
    end
    total += local_total
  end
  total
end

def part_1(raw_problems)
  problems = []
  raw_problems.each do |line|
    problems = Array.new(line.scan(/\d+/).length) { [] } if problems.empty?
    line.scan(/\d+/).map(&:to_i).each_with_index do |ops, index|
      problems[index] << ops
    end
    line.scan(/\*|\+/).each_with_index do |ops, index|
      problems[index] << ops
    end
  end
  problems
end

def part_2(raw_problems)
  problems = []
  current_problem = []
  current_operation = ''
  (0..(raw_problems[0].length - 1)).each do |col_index|
    current_number = []
    (0..(raw_problems.length - 2)).each do |index_char|
      current_number << raw_problems[index_char][col_index]
    end
    current_number = current_number.join.strip.to_i
    current_problem << current_number unless current_number == 0
    if current_number == 0 || col_index == (raw_problems[0].length - 1)
      current_problem << current_operation
      problems << current_problem
      current_problem = []
      current_operation = ''
    end

    current_operation = raw_problems[-1][col_index] if raw_problems[-1][col_index] != ' '
  end
  problems
end

raw_problems = []
puzzle_input.each do |line|
  raw_problems << line
end

# problems = part_1(raw_problems)
problems = part_2(raw_problems)

total = calculate_total(problems)

p "Total : #{total}"
