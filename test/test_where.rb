require 'where'

class TestWhere < MiniTest::Unit::TestCase
  def setup
    @newline_json = <<-JSON2
      {"id":"1"}
      {"id":"2"}
      {"id":"3"}

      {"id":"4"}
      {hello
      {"id":"5"}
      {"id":"6"}
      {"object": {"id":"hello"}}
    JSON2
  end

  def test_where_equality
    filter = Where.new("id", @newline_json, "4")
    assert_equal ['{"id":"4"}'], filter.out
  end

  def test_where_regexp
    filter = Where.new("id", @newline_json, "/\\d/")
    valid_json = @newline_json.split("\n").select do |l|
      JSON.parse(l) rescue false
    end
    assert_equal valid_json.map(&:strip)[0..-2], filter.out
  end

  def test_where_regexp_on_json
    filter = Where.new("object", @newline_json, "/\"hello\"}/")
    assert_equal ['{"object": {"id":"hello"}}'], filter.out

  end
end
