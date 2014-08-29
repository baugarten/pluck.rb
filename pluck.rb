#!/usr/bin/ruby

require 'json'
require 'jsonpath'
require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: pluck.rb [options] path file"

  opts.on("-m", "--map", "Map over a list of JSON") do |map|
    options[:map] = map
  end
end.parse!

path = ARGV.shift

def parse(path, json)
  path = JsonPath.new(path)
  results = path.on(json)
  if results[0].class == Hash or results[0].class == Array
    puts results[0].to_json
  else
    puts results
  end
end


if options[:map]
  ARGF.each_line do |l|
    parse(path, l) rescue next
  end
else
  parse(path, ARGF.read)
end

