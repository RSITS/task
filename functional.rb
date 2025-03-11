# frozen_string_literal: true

require_relative 'license'

def valid_input?(version)
  raise ArgumentError, 'invalid version' unless version.match?(/^\d{2}\.\d{2}$/)
end

def make_license
  puts 'enter paid_till yyyy-mm-dd'
  paid_till = Date.parse(gets.chomp)
  max_version = read_max
  min_version = read_min

  License.new(paid_till, max_version, min_version)
rescue ArgumentError => e
  puts "wtf are you doing #{e.message}"
  retry
end

def read_max
  puts 'enter max_version yy.mm or skip'
  max_version = gets.chomp
  valid_input?(max_version) unless max_version.empty?
  max_version.empty? ? nil : max_version
end

def read_min
  puts 'enter min_version yy.mm or skip'
  min_version = gets.chomp
  valid_input?(min_version) unless min_version.empty?
  min_version.empty? ? nil : min_version
end
