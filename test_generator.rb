# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'flussonic_versions_generator'
require_relative 'version'
require 'date'

# this class for testing versions generator
class TestVersionsGenerator < Minitest::Test
  def test_make_last_versions
    last_flussonic_vers = [Version.new('25.10')]
    num = 5
    year = 25
    month = 10

    result = VersionsGenerator.make_last_versions(last_flussonic_vers, num, year, month)
    expected = ['25.06', '25.07', '25.08', '25.09', '25.10']

    assert_equal expected, result.map(&:date)
  end

  def test_make_last_versions_one
    last_flussonic_vers = [Version.new('25.10')]
    num = 1
    year = 25
    month = 10

    result = VersionsGenerator.make_last_versions(last_flussonic_vers, num, year, month)
    expected = ['25.10']

    assert_equal expected, result.map(&:date)
  end

  def test_make_last_versions_two_years
    last_flussonic_vers = [Version.new('25.03')]
    num = 5
    year = 25
    month = 0o3

    result = VersionsGenerator.make_last_versions(last_flussonic_vers, num, year, month)
    expected = ['24.11', '24.12', '25.01', '25.02', '25.03']

    assert_equal expected, result.map(&:date)
  end

  def test_make_one_date_version
    current_date = Date.new(2025, 10, 1)
    num = 1

    result = VersionsGenerator.generate_versions(current_date, num)
    expected = ['25.10']

    assert_equal expected, result.map(&:date)
  end

  def test_make_no_versions
    current_date = Date.new(2025, 10, 1)
    num = 0

    result = VersionsGenerator.generate_versions(current_date, num)
    expected = []

    assert_equal expected, result.map(&:date)
  end
end
