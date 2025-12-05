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

  doc = fetch_puzzle_page(day)
  code_block = doc.at_css('pre code')

  File.open(file_path, 'w') { |f| f.write(code_block.text) } if code_block
end

def fetch_puzzle_page(day)
  uri = URI("#{AOC_URL}/day/#{day}")
  res = fetch_page(uri)
  Nokogiri::HTML(res.body)
end

def scrape_puzzle_description(day, file_path)
  doc = fetch_puzzle_page(day)
  articles = doc.css('article.day-desc')

  markdown = articles.map { |article| html_to_markdown(article) }.join("\n\n---\n\n")
  File.open(file_path, 'w') { |f| f.write(markdown) }
end

def html_to_markdown(element)
  element.children.filter_map { |node| node_to_markdown(node) }.join("\n")
end

def node_to_markdown(node)
  case node.name
  when 'h2' then "## #{node.text.gsub(/---/, '').strip}\n"
  when 'p' then "#{parse_inline(node)}\n"
  when 'pre' then "```\n#{node.text}```\n"
  when 'ul' then list_to_markdown(node)
  when 'text' then node.text unless node.text.strip.empty?
  end
end

def list_to_markdown(node)
  "#{node.css('li').map { |li| "- #{parse_inline(li)}" }.join("\n")}\n"
end

def parse_inline(node)
  node.children.map do |child|
    case child.name
    when 'text' then child.text
    when 'em' then "*#{child.text}*"
    when 'code' then "`#{child.text}`"
    when 'a' then "[#{child.text}](#{child['href']})"
    when 'strong' then "**#{child.text}**"
    else child.text
    end
  end.join
end

def fetch_page(uri)
  req = Net::HTTP::Get.new(uri)
  req['cookie'] = SESSION_COOKIE
  Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(req)
  end
end
