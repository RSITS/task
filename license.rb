# frozen_string_literal: true

require_relative 'version'

# this class contain info about license
class License
  def initialize
    puts 'enter paid_till yyyy-mm-dd'
    @paid_till = Version.new(Version.read_version_in_date_format)

    puts 'enter max_version yy.mm or just press enter and skip'
    @max_version = Version.new(Version.read_version)

    puts 'enter min_version yy.mm or just press enter and skip'
    @min_version = Version.new(Version.read_version)
  end

  attr_accessor :paid_till, :max_version, :min_version

  def to_s
    "license info:\n" \
    "paid till: #{@paid_till}\n" \
    "max_vers: #{@max_version}\n" \
    "min_vers: #{@min_version}\n"
  end

  def self.make_license
    license = License.new
    license.read_versions
    license
  rescue ArgumentError => e
    puts "please correct this #{e.message}"
    retry
  end

  def available_vers(flussonic_versions)
    available_vers = flussonic_versions.select do |version|
      Version.compare_vers(version, @paid_till) <= 0 &&
        (@max_version.date.nil? || Version.compare_vers(version, @max_version) <= 0) &&
        (@min_version.date.nil? || Version.compare_vers(version, @min_version) >= 0)
    end
    available_vers.empty? ? [@max_version.date] : available_vers
  end
end
