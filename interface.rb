# frozen_string_literal: true

require 'date'
require_relative 'functional'
require_relative 'flussonic_versions_generator'

# last_flussonic_vers = ["24.12", "25.01", "25.02", "25.03"]

def interface
  puts "Start\n"

  current_date = read_current_date
  last_flussonic_vers = generate_versions_arr(current_date)
  print last_flussonic_vers
  puts
  num = read_num
  puts "wv: #{last_flussonic_vers.last(num)}"
  license = make_license

  puts "available_versions: #{find_available_vers(license, last_flussonic_vers, num)}"
end

interface
