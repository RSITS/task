# frozen_string_literal: true

require 'date'
require_relative 'functional'
require_relative 'flussonic_versions_generator'
require_relative 'license'

def interface
  puts "Start\n"
  last_flussonic_vers = VersionsGenerator.generate_versions
  puts last_flussonic_vers
  license = License.new
  puts 'available_versions:'
  puts license.available_vers(last_flussonic_vers)
end

interface
