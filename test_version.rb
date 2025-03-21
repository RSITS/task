# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'version'
require 'date'

# this class for testing version functional
class TestVersion < Minitest::Test
  def test_initialize_and_to_s
    version = Version.new('25.19')
    assert_equal '25.19', version.to_s
  end

  def test_compare_vers
    v1 = Version.new('25.05')
    v2 = Version.new('25.10')
    v3 = Version.new('26.01')

    assert_equal(-1, Version.compare_vers(v1, v2))
    assert_equal(1, Version.compare_vers(v2, v1))
    assert_equal(0, Version.compare_vers(v1, v1))
    assert_equal(-1, Version.compare_vers(v1, v3))
  end

  def test_formate_date
    date = Date.new(2025, 10, 15)
    result = Version.formate_date(date)
    assert_equal '25.10', result
  end

  def test_input_validation
    assert_raises(ArgumentError, 'invalid version') { Version.input_validation('25-11') }
  end
end
