# frozen_string_literal: true

require 'date'
require_relative 'flussonic_versions_generator'
require_relative 'license'

# this class for user interface
class Interface
  def self.interface
    puts "Start\n"
    last_flussonic_vers = VersionsGenerator.generate_versions
    puts last_flussonic_vers
    license = License.new
    license.make_license
    puts 'available_versions:'
    puts license.available_versions(last_flussonic_vers)
  end
end

Interface.interface
