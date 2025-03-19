# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'license'
require 'date'

# this class for testing license functional
class TestLicense < Minitest::Test
  def test_initialize
    paid_till = Version.new('25.08')
    max_version = Version.new('20.02')
    min_version = Version.new('19.01')
    license = License.new(paid_till, max_version, min_version)
    assert_equal '25.08', license.paid_till.date
    assert_equal '20.02', license.max_version.date
    assert_equal '19.01', license.min_version.date
  end

  def test_available_versions
    paid_till = Version.new('25.08')
    max_version = Version.new
    min_version = Version.new
    license = License.new(paid_till, max_version, min_version)
    flussonic_versions = [Version.new('25.07'), Version.new('25.08'), Version.new('25.09'), Version.new('25.10')]
    available = license.available_versions(flussonic_versions)
    expected = ['25.07', '25.08']
    assert_equal expected, available.map(&:date)
  end

  def test_available_versions_not_found
    paid_till = Version.new('25.07')
    max_version = Version.new('20.02')
    min_version = Version.new('19.01')
    license = License.new(paid_till, max_version, min_version)
    flussonic_versions = [Version.new('24.12'), Version.new('25.01'), Version.new('25.02'), Version.new('25.03')]
    available = license.available_versions(flussonic_versions)
    expected = ['20.02']
    assert_equal expected, available
  end

  def test_available_versions_min_greater_than_max
    paid_till = Version.new('25.08')
    max_version = Version.new('25.07')
    min_version = Version.new('25.09')
    license = License.new(paid_till, max_version, min_version)
    flussonic_versions = [Version.new('25.06'), Version.new('25.07'), Version.new('25.08'), Version.new('25.09')]
    available = license.available_versions(flussonic_versions)
    expected = ['25.07']
    assert_equal expected, available
  end
end
