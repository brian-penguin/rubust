# frozen_string_literal: true

require "test_helper"

class RubustTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::Rubust.const_defined?(:VERSION)
    end
  end

  test "calling into our rust hellow world works" do
    assert_equal("Hello from Rust, Brian!", Rubust.hello("Brian"))
  end
end
