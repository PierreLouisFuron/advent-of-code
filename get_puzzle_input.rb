# frozen_string_literal: true

require 'uri'
require 'net/http'
require './env'

require 'nokogiri'

DIR_PATH = "./#{CURRENT_YEAR}/puzzle_inputs/day_"
DIR_NAME = "#{CURRENT_YEAR}/puzzle_inputs"
AOC_URL = "https://adventofcode.com/#{CURRENT_YEAR}"

def get_puzzle_inputs(day)
  dir_name = "#{DIR_PATH}#{day}"
  file_path = "#{dir_name}/full_input_day_#{day}.txt"
  test_file_path = "#{dir_name}/full_input_day_#{day}_test.txt"
  create_dir(dir_name)
  request_puzzle(day, file_path)
  scrap_test_input(day, test_file_path)
  File.read(file_path)
end

def create_dir(dir_name)
  Dir.mkdir(DIR_NAME) unless File.exist?(DIR_NAME)
  Dir.mkdir(dir_name) unless File.exist?(dir_name)
end

def request_puzzle(day, file_path)
  return if File.exist?(file_path)

  # e.g. https://adventofcode.com/2023/day/1/input

  uri = URI("#{AOC_URL}/day/#{day}/input")
  res = fetch_page(uri)

  File.open(file_path, 'w') { |f| f.write(res.body) }
end

def scrap_test_input(day, file_path)
  return if File.exist?(file_path)

  uri = URI("#{AOC_URL}/day/#{day}")
  res = fetch_page(uri)

  doc = Nokogiri::HTML(res.body)
  code_block = doc.at_css('pre code')

  File.open(file_path, 'w') { |f| f.write(code_block.text) } if code_block
end

def fetch_page(uri)
  req = Net::HTTP::Get.new(uri)
  req['cookie'] = SESSION_COOKIE
  Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(req)
  end
end
