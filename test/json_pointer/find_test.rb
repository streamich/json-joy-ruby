require_relative "../../lib/json_pointer/json_pointer"
require 'json'
require "test_helper"

class JsonPointerFindTest < Minitest::Test

  def test_returns_root_doc_if_pointer_is_empty
    ref = Json::Pointer.find({}, [])
    assert_equal({}, ref.val)
  end

  def test_can_find_root_number
    doc = JSON.parse '123'
    path = Json::Pointer.parse ''
    ref = Json::Pointer.find doc, path

    assert_equal 123, ref.val
    assert_nil ref.obj
    assert_nil ref.key
  end

  def test_can_find_root_strign
    doc = JSON.parse '"a"'
    path = Json::Pointer.parse ''
    ref = Json::Pointer.find doc, path

    assert_equal 'a', ref.val
    assert_nil ref.obj
    assert_nil ref.key
  end

  def test_find_a_value_in_simple_object
    doc = JSON.parse '{"foo": {"a": 1.1}}'
    path = Json::Pointer.parse '/foo/a'
    ref = Json::Pointer.find doc, path

    assert_equal 1.1, ref.val
    assert_equal JSON.parse('{"a": 1.1}'), ref.obj
    assert_equal 'a', ref.key
  end

  def test_find_in_an_array
    doc = JSON.parse '{"foo": {"bar": [2, null, "baz"]}}'
    path = Json::Pointer.parse '/foo/bar/2'
    ref = Json::Pointer.find doc, path

    assert_equal 'baz', ref.val
    assert_equal JSON.parse('[2, null, "baz"]'), ref.obj
    assert_equal 2, ref.key
  end

end
