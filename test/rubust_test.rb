# frozen_string_literal: true

require "test_helper"
require "pathname"

class RubustTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::Rubust.const_defined?(:VERSION)
    end
  end

  test "#hello into our rust hello function works" do
    assert_equal("Hello from Rust, Brian!", Rubust.hello("Brian"))
  end

  test "#parse_csv raises a StandardError for a non-existant file" do
    assert_raise StandardError do
      Rubust.parse_csv("i-dont-exist.csv", false)
    end
  end

  test "#parse_csv works with a relative file path" do
    file = "./test/support/example.csv"

    expected = [["foo", "bar"], ["a", "b"], ["c", "d"]]
    assert_equal(expected, Rubust.parse_csv(file, true))
  end

  test "#parse_csv returns the whole data including headers when passing in true" do
    file = Pathname.new("./test/support/example.csv")
    abs_file_path = file.realpath.to_s

    expected = [["foo", "bar"], ["a", "b"], ["c", "d"]]
    assert_equal(expected, Rubust.parse_csv(abs_file_path, true))
  end

  test "#parse_csv returns a records without headers" do
    file = Pathname.new("./test/support/example.csv")
    abs_file_path = file.realpath.to_s

    expected = [["a", "b"], ["c", "d"]]
    assert_equal(expected, Rubust.parse_csv(abs_file_path, false))
  end

  test "#parse_csv raises an error if there are incomplete rows" do
    file = "./test/support/malformed.csv"
    assert_raise StandardError do
      Rubust.parse_csv(file, true)
    end
  end

  test "#parse_csv returns an empty string value for a row missing a value" do
    file = Pathname.new("./test/support/missing_values.csv")
    abs_file_path = file.realpath.to_s

    expected = [["a", ""], ["c", "d"]]
    assert_equal(expected, Rubust.parse_csv(abs_file_path, false))
  end

  test "#parse_csv_to_hash returns an array of hashes with the row headers as keys" do
    file = "./test/support/example.csv"

    expected = [{"foo" => "a", "bar" => "b"}, {"foo" => "c", "bar" => "d"}]
    assert_equal(expected, Rubust.parse_csv_to_hash(file))
  end
end
