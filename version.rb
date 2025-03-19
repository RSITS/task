# frozen_string_literal: true

# this class contain version implementation
class Version
  def initialize(date)
    @date = date
  end

  attr_accessor :date

  def to_s
    @date
  end

  def self.read_version
    version = gets.chomp
    valid_input?(version) unless version.empty?
    version.empty? ? nil : version
  end

  def self.read_version_in_date_format
    version = Date.parse(gets.chomp)
    "#{version.year % 100}.#{format('%02d', version.month)}"
  end

  def self.compare_vers(version1, version2)
    v1 = version1.date.split('.').map(&:to_i)
    v2 = version2.date.split('.').map(&:to_i)

    if v1[0] != v2[0]
      v1[0] <=> v2[0]
    else
      v1[1] <=> v2[1]
    end
  end

  def self.formate_date(date)
    "#{date.year % 100}.#{format('%02d', date.month)}"
  end

  def self.valid_input?(version)
    raise ArgumentError, 'invalid version' unless version.match?(/^\d{2}\.\d{2}$/)
  end
end
