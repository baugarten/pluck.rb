require 'pluck'

class TestPluck < MiniTest::Unit::TestCase
  def setup
    @json = <<-EOF
      {
        "id": "12345",
        "text": "hello",
        "array": [
          { "of": "objects" },
          { "of": "moar objects" }
        ],
        "object": {
          "to": {
            "rule": {
              "all": "objects"
            }
          }
        }
      }
    EOF
    @newline_json = <<-JSON2
      {"id":"1"}
      {"id":"2"}
      {"id":"3"}

      {"id":"4"}
      {hello
      {"id":"5"}
      {"id":"6"}
    JSON2
  end

  def test_no_map
    plucker = Pluck.new("id", @json)
    assert_equal ["12345"], plucker.out
  end

  def test_extracts_array
    plucker = Pluck.new("array", @json)
    assert_equal ['[{"of":"objects"},{"of":"moar objects"}]'], plucker.out
  end
  def test_extracts_object
    plucker = Pluck.new("object.to", @json)
    assert_equal ['{"rule":{"all":"objects"}}'], plucker.out
  end
  def test_map
    plucker = Pluck.new("id", @newline_json, true)
    assert_equal ["1", "2", "3", "4", "5", "6"], plucker.out
  end
end
