# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'nokogiri'
require './env'

AOC_URL = "https://adventofcode.com/#{CURRENT_YEAR}"

def submit_answer(day, answer, level = nil)
  level ||= determine_level(day)

  uri = URI("#{AOC_URL}/day/#{day}/answer")
  res = post_answer(uri, level, answer)

  parse_response(res.body)
end

def determine_level(day)
  uri = URI("#{AOC_URL}/day/#{day}")
  res = fetch_page(uri)
  doc = Nokogiri::HTML(res.body)

  # If part 2 is visible, we're on level 2
  doc.css('article.day-desc').count
end

def post_answer(uri, level, answer)
  http = Net::HTTP.new(uri.hostname, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  req = Net::HTTP::Post.new(uri)
  req['cookie'] = SESSION_COOKIE
  req.set_form_data('level' => level, 'answer' => answer)
  http.request(req)
end

def fetch_page(uri)
  http = Net::HTTP.new(uri.hostname, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  req = Net::HTTP::Get.new(uri)
  req['cookie'] = SESSION_COOKIE
  http.request(req)
end

def parse_response(body)
  doc = Nokogiri::HTML(body)
  article = doc.at_css('article')
  return 'Could not parse response' unless article

  text = article.text.strip

  if text.include?("That's the right answer")
    "\e[32m✓ #{text.split('  ').first}\e[0m \n#{text.split('  ')[1..].join.capitalize.sub(/\s*\[.*?\]\s*$/,
                                                                                          '').strip.capitalize}"
  elsif text.include?("That's not the right answer")
    "\e[31m✗ #{text.split(';').first}.\e[0m \n#{text.split(';')[1..].join.capitalize.sub(/\s*\[.*?\]\s*$/,
                                                                                         '').strip.capitalize}"
  elsif text.include?('You gave an answer too recently')
    "\e[33m⏳ #{text.split(';').first}.\e[0m \n#{text.split(';')[1..].join.sub(/\s*\[.*?\]\s*$/, '').strip.capitalize}"
  elsif text.include?("You don't seem to be solving the right level")
    "\e[33m✓ #{text.split('  ').first}\e[0m \n#{text.split('  ')[1..].join.capitalize.sub(/\s*\[.*?\]\s*$/,
                                                                                          '').strip.capitalize}"
  else
    text
  end
end

day = ARGV[0]
answer = ARGV[1]
level = ARGV[2]&.to_i

if day.nil? || answer.nil?
  puts 'Usage: ruby submit_answer.rb <day> <answer> [level]'
  puts 'Example: ruby submit_answer.rb 7 294738'
  puts 'Level is auto-detected if not provided (1 or 2)'
  exit 1
end

puts "Submitting answer '#{answer}' for day #{day}..."
puts submit_answer(day, answer, level)
