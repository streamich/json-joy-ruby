require_relative "../../lib/json_pointer/json_pointer"
require "test_helper"

class JsonPointerParsingTest < Minitest::Test
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


class JsonPointerFormattingTest < Minitest::Test
  def test_returns_emtpy_string_for_empty_array
    assert_equal '', Json::Pointer.format([])
  end

  def test_returns_valid_json_pointer_string_for_a_single_compoennt
    assert_equal '/foo', Json::Pointer.format(['foo'])
  end

  def test_returns_valid_json_pointer_string_for_two_compoennts
    assert_equal '/foo/bar', Json::Pointer.format(['foo', 'bar'])
  end

  def test_encodes_special_characters
    assert_equal '/a~0b/c~1d/1', Json::Pointer.format(['a~b', 'c/d', '1'])
  end
end
