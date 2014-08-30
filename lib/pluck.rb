require 'json'
require 'jsonpath'

class Pluck
  def initialize(path, input, map = false, verbose = false)
    @path = path
    @verbose = verbose
    if map
      @_out = input.lines.map do |line|
        begin
          parsed = parse(line)
        rescue StandardError => e
          parsed = nil
          $stderr.puts e
          $stderr.puts "Could not parse line #{line}"
        end
        parsed
      end.compact
    else
      @_out = [parse(input)]
    end
  end

  def parse(input)
    res = JsonPath.on(input, @path)[0]
    p res if @verbose
    if (res.class == Hash or res.class == Array)
      res.to_json
    else
      res
    end
  end

  def out
    @_out
  end
end
