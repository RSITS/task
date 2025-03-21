# frozen_string_literal: true

require_relative 'version'

# this class contain info about license
class License
  def initialize(paid_till = nil, max_version = nil, min_version = nil)
    @paid_till = paid_till
    @max_version = max_version
    @min_version = min_version
  end

  attr_accessor :paid_till, :max_version, :min_version

  def to_s
    "license info:\n" \
    "paid till: #{@paid_till}\n" \
    "max_vers: #{@max_version}\n" \
    "min_vers: #{@min_version}\n"
  end

  def available_versions(flussonic_versions)
    available_vers = flussonic_versions.select do |version|
      Version.compare_vers(version, @paid_till) <= 0 &&
        (@max_version.date.nil? || Version.compare_vers(version, @max_version) <= 0) &&
        (@min_version.date.nil? || Version.compare_vers(version, @min_version) >= 0)
    end
    available_vers.empty? ? [@max_version.date] : available_vers
  end
end
