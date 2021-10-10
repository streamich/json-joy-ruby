require_relative "../../lib/json_pointer/json_pointer"
require "test_helper"

class JsonPointerConversionTest < Minitest::Test

  def test_returns_empty_array_for_empty_string
    assert_equal [], Json::Pointer.parse('')
  end

  def test_converts_string_to_json_pointer_path
    pointer = Json::Pointer.parse "/a/b/c"
    assert_kind_of Array, pointer
    assert_equal ["a", "b", "c"], pointer
  end

  def test_trailing_slashes_result_in_empty_string_components
    pointer = Json::Pointer.parse "/foo///"
    assert_equal ["foo", "", "", ""], pointer
  end

  def test_a_single_slash_returns_a_single_empty_component
    pointer = Json::Pointer.parse "/"
    assert_equal [""], pointer
  end

  def test_unescapes_escaped_components
    pointer = Json::Pointer.parse "/a~0b/c~1d/1"
    assert_equal ['a~b', 'c/d', '1'], pointer
  end

end
