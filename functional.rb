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
  puts "please correct this #{e.message}"
  retry
end

def read_max
  puts 'enter max_version yy.mm or skip'
  max_version = gets.chomp
  valid_input?(max_version) unless max_version.empty?
  max_version.empty? ? '00.00' : max_version
end

def read_min
  puts 'enter min_version yy.mm or skip'
  min_version = gets.chomp
  valid_input?(min_version) unless min_version.empty?
  min_version.empty? ? '100.100' : min_version
end

def read_current_date
  puts 'enter current_date yyyy-mm-dd'
  Date.parse(gets.chomp)
end

def read_num
  puts 'enter limit of last versions(n)'
  num = gets.chomp
  Integer(num)
rescue ArgumentError => e
  puts "please correct this #{e.message}"
  retry
end

def compare_vers(version1, version2)
  v1 = version1.split('.').map(&:to_i)
  v2 = version2.split('.').map(&:to_i)

  if v1[0] != v2[0]
    v1[0] <=> v2[0]
  else
    v1[1] <=> v2[1]
  end
end

def find_available_vers(license, last_flussonic_vers, num)
  formated_pt = "#{license.paid_till.year % 100}.#{format('%02d', license.paid_till.month)}"
  working_vers = last_flussonic_vers.last(num)

  return [license.max_version] unless license.max_version == '00.00' || working_vers.include?(license.max_version)

  return [license.max_version] unless compare_vers(formated_pt, license.max_version) == 1

  make_av_vers_arr(working_vers, formated_pt, license)
end

def make_av_vers_arr(working_vers, formated_pt, license)
  available_vers = working_vers.select do |version|
    compare_vers(version, formated_pt) <= 0 &&
      license.max_version == '00.00' || compare_vers(version, license.max_version) <= 0 &&
        license.min_version == '00.00' || compare_vers(version, license.min_version) >= 0
  end
  available_vers.empty? ? [license.max_version] : available_vers
end
