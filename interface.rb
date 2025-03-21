# frozen_string_literal: true

require 'date'
require_relative 'flussonic_versions_generator'
require_relative 'license'
require_relative 'version'

# this class for user interface and reading from console
class Interface
  def self.interface
    puts "Start\n"
    last_flussonic_vers = VersionsGenerator.generate_versions(read_current_date, read_num)
    puts 'last_versions:'
    puts last_flussonic_vers
    license = License.new
    make_license(license)
    puts 'available_versions:'
    puts license.available_versions(last_flussonic_vers)
  end

  def self.read_version
    version = gets.chomp
    Version.input_validation(version) unless version.empty?
    version.empty? ? nil : version
  end

  def self.read_version_in_date_format
    version = Date.parse(gets.chomp)
    Version.formate_date(version)
  end

  def self.make_license(license)
    puts 'enter paid_till yyyy-mm-dd'
    license.paid_till = Version.new(read_version_in_date_format)

    puts 'enter max_version yy.mm or just press enter and skip'
    license.max_version = Version.new(read_version)

    puts 'enter min_version yy.mm or just press enter and skip'
    license.min_version = Version.new(read_version)
  rescue ArgumentError => e
    puts "please correct this #{e.message}"
    retry
  end

  def self.read_current_date
    puts 'enter current_date yyyy-mm-dd'
    Date.parse(gets.chomp)
  rescue ArgumentError => e
    puts "please correct this #{e.message}"
    retry
  end

  def self.read_num
    puts 'enter limit of last versions(n)'
    num = gets.chomp
    integer_validation(num)
  rescue ArgumentError => e
    puts "please correct this #{e.message}"
    retry
  end

  def self.integer_validation(number)
    num = Integer(number)
    raise ArgumentError unless num.positive?

    num
  rescue ArgumentError
    raise ArgumentError, 'not valid number'
  end
end
