# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'license'
require_relative 'functional'
require_relative 'flussonic_versions_generator'
require 'date'

# this class for testing license creation
class TestLicense < Minitest::Test
  def test_license_creation
    license = License.new(Date.new(2025, 3, 14), '25.02', '25.01')
    assert_equal Date.new(2025, 3, 14), license.paid_till
    assert_equal '25.02', license.max_version
    assert_equal '25.01', license.min_version
  end
end

# this class for testing program functional
class TestFunctional < Minitest::Test
  def test_valid_input?
    assert_raises(ArgumentError) { valid_input?('abc') }
    assert_raises(ArgumentError) { valid_input?('1.12') }
    assert_raises(ArgumentError) { valid_input?('25-03') }
    assert_nil(valid_input?('25.03'))
  end

  def test_nil_read_max
    input = StringIO.new("\n")
    $stdin = input
    assert_nil nil, read_max
  ensure
    $stdin = STDIN
  end

  def test_normal_read_max
    input = StringIO.new("25.03\n")
    $stdin = input
    assert_equal '25.03', read_max
  ensure
    $stdin = STDIN
  end

  def test_nil_read_min
    input = StringIO.new("\n")
    $stdin = input
    assert_nil nil, read_min
  ensure
    $stdin = STDIN
  end

  def test_normal_read_min
    input = StringIO.new("25.03\n")
    $stdin = input
    assert_equal '25.03', read_min
  ensure
    $stdin = STDIN
  end

  def test_read_current_date
    input = StringIO.new("2025-10-01\n")
    $stdin = input
    assert_equal Date.new(2025, 10, 1), read_current_date
  ensure
    $stdin = STDIN
  end

  def test_read_num
    input = StringIO.new("4\n")
    $stdin = input
    assert_equal 4, read_num
  ensure
    $stdin = STDIN
  end

  def test_compare_vers
    assert_equal(-1, compare_vers('24.12', '25.05'))
    assert_equal(0, compare_vers('25.03', '25.03'))
    assert_equal(1, compare_vers('25.03', '25.01'))
  end

  def test_make_av_vers_arr
    working_vers = ['25.03', '25.04', '25.05', '25.06']
    formated_pt = '25.05'
    license = License.new(Date.new(2025, 6, 30), '25.06', '25.01')
    result = make_av_vers_arr(working_vers, formated_pt, license)
    assert_equal ['25.03', '25.04', '25.05'], result
  end

  def test_find_available_vers
    license = License.new(Date.new(2025, 7, 10), '20.02', '19.01')
    working_vers = ['24.12', '25.01', '25.02', '25.03']
    result = find_available_vers(license, working_vers)
    assert_equal ['20.02'], result
  end
end

# this class for testing version generator
class TestFlussonicVersionGenerator < Minitest::Test
  def test_make_last_vers
    last_flussonic_vers = ['25.03']
    num = 2
    year = 25
    month = 3
    result = make_last_vers(last_flussonic_vers, num, year, month)
    assert_equal ['25.02', '25.03'], result
  end

  def test_generate_versions_arr
    current_date = Date.new(2025, 6, 30)
    num = 3
    result = generate_versions_arr(current_date, num)
    assert_equal ['25.04', '25.05', '25.06'], result
  end
end
