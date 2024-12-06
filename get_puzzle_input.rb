# frozen_string_literal: true

require 'uri'
require 'net/http'
require './env'

DIR_PATH = "./#{CURRENT_YEAR}/puzzle_inputs/day_".freeze
DIR_NAME = "#{CURRENT_YEAR}/puzzle_inputs".freeze
AOC_URL = "https://adventofcode.com/#{CURRENT_YEAR}".freeze

def get_puzzle_input(day)
  dir_name = "#{DIR_PATH}#{day}"
  file_path = "#{dir_name}/full_input_day_#{day}.txt"
  create_dir(dir_name)
  request_puzzle(day, file_path)
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
  req = Net::HTTP::Get.new(uri)
  req['cookie'] = SESSION_COOKIE
  res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(req)
  end
  File.open(file_path, 'w') { |f| f.write(res.body) }
end
