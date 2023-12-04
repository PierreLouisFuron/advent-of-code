# frozen_string_literal: true

require 'uri'
require 'net/http'
require './cookie'

DIR_PATH = './puzzle_inputs/day_'
DIR_NAME = 'puzzle_inputs'
AOC_URL_2023 = 'https://adventofcode.com/2023'

def get_puzzle_input(day)
  dir_name = "#{DIR_PATH}#{day}"
  file_path = "#{dir_name}/full_input_day_#{day}.txt"
  create_dir(dir_name)
  request_puzzle(day, file_path)
  File.read(file_path)
end

def create_dir(dir_name)
  Dir.mkdir(DIR_NAME) unless File.exists?(DIR_NAME)
  Dir.mkdir(dir_name) unless File.exist?(dir_name)
end

def request_puzzle(day, file_path)
  return if File.exist?(file_path)

  # e.g. https://adventofcode.com/2023/day/1/input

  uri = URI("#{AOC_URL_2023}/day/#{day}/input")
  req = Net::HTTP::Get.new(uri)
  req['cookie'] = COOKIE
  res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(req)
  end
  File.open(file_path, 'w') { |f| f.write(res.body) }
end

day = ARGV.first

get_puzzle_input(day)
