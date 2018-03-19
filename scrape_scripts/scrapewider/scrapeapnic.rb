#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

# Fetch and parse HTML document
doc = Nokogiri::HTML(open('https://stats.labs.apnic.net/cgi-bin/v6pop'))

puts "### Search for nodes by xpath"
doc.xpath('/html/head/script[2]/text()').each do |link|
  puts link.content
end

