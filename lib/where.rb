require 'json'
require 'jsonpath'
require 'pluck'

class Where < Pluck
  def initialize(path, input, filter)
    @path = path
    if filter[0] == "/" and filter[-1] == "/" 
      @matcher = RegMatcher.new(filter[1..-2]) 
    else 
      @matcher = EqualityMatcher.new(filter)
    end
    out = input.lines.select do |line|
      begin
        val = parse(line)
        @matcher.match? val
      rescue
        $stderr.puts "Could not parse line #{line}"
        false
      end
    end
    @_out = out.map(&:strip)
  end
end

class RegMatcher
  def initialize(regexp)
    @regexp = Regexp.new(regexp)
  end

  def match?(value)
    @regexp.match value
  end
end

class EqualityMatcher
  def initialize(expected)
    @expected = expected
  end
  
  def match?(value)
    @expected == value
  end
end
