require_relative "../../lib/json_pointer/json_pointer"
require "test_helper"

class JsonPointerParseTest < Minitest::Test

  def test_unescapes_special_characters
    assert_equal(Json::Pointer.unescape_component('~0'), '~')
    assert_equal(Json::Pointer.unescape_component('~1'), '/')
  end

  def test_unescapes_special_characters_in_right_order
    assert_equal(Json::Pointer.unescape_component('a~0~1~1~0b'), 'a~//~b')
  end

  def test_unescape_leaves_non_special_characters_as_is
    assert_equal(Json::Pointer.unescape_component('~2foo'), '~2foo')
  end

  def test_escapes_special_characters
    assert_equal(Json::Pointer.escape_component('foo~/'), 'foo~0~1')
    assert_equal(Json::Pointer.escape_component('~'), '~0')
    assert_equal(Json::Pointer.escape_component('/'), '~1')
  end

  def test_escape_leaves_non_special_characters_as_is
    assert_equal(Json::Pointer.escape_component('foobar'), 'foobar')
  end

end
