# frozen_string_literal: true

#
# The unusual data (your puzzle input) consists of many reports, one report per line. Each report is a list of numbers called levels that are separated by spaces. For example:
# 7 6 4 2 1
# 1 2 7 8 9
# 9 7 6 2 1
# 1 3 2 4 5
# 8 6 4 4 1
# 1 3 6 7 9
# This example data contains six reports each containing five levels.
# The engineers are trying to figure out which reports are safe. The Red-Nosed reactor safety systems can only tolerate levels that are either gradually increasing or gradually decreasing. So, a report only counts as safe if both of the following are true:
# The levels are either all increasing or all decreasing.
# Any two adjacent levels differ by at least one and at most three.

def strictly_increasing?(report)
  report.each_cons(2).all? { |a, b| a < b }
end

def strictly_decreasing?(report)
  report.each_cons(2).all? { |a, b| a > b }
end

def evolving_gradually?(report)
  report.each_cons(2).all? { |a, b| (a - b).abs < 4 }
end

def report_safe?(report)
  return true if evolving_gradually?(report) && (strictly_decreasing?(report) || strictly_increasing?(report))

  false
end

def test_subreports(report)
  subreports = report.each_index.map { |i| report[0...i] + report[(i + 1)..] }
  subreports.each do |subreport|
    return true if report_safe?(subreport)
  end

  false
end

# puzzle_input = File.readlines('small_input_day_2.txt', chomp: true)
puzzle_input = File.readlines('full_input_day_2.txt', chomp: true)
number_of_safe_reports = 0
puzzle_input.each do |line|
  report = line.split(' ')
  report = report.map(&:to_i)
  number_of_safe_reports += 1 if report_safe?(report) || test_subreports(report)
end

p number_of_safe_reports
