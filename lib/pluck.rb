require 'json'
require 'jsonpath'

class Pluck
  def initialize(path, input, map = false)
    @path = path
    if map
      @out = input.lines.map do |line|
        begin
          parse(line)
        rescue
          $stderr.puts "Could not parse line #{line}"
        end
      end.compact!
    else
      @out = [parse(input)]
    end
  end

  def parse(input)
    res = JsonPath.on(input, @path)[0]
    if (res.class == Hash or res.class == Array)
      res.to_json
    else
      res
    end
  end

  def out
    @out
  end
end
