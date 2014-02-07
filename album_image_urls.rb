#!/usr/bin/env ruby
require 'net/http'
require 'net/https'
require 'json'

def imgur_data
  headers = { "Authorization" => "Client-ID CLIENT_ID"}
  path    = "/3/album/ALBUM_ID.json"
  uri     = URI.parse("https://api.imgur.com"+path)
  request = Net::HTTP::Get.new(path, headers)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  response = http.request(request)
  response.body
end

def album_json
  JSON.parse(imgur_data)
end

def images
  album_json["data"]["images"]
end

def output_urls
  images.each do |image|
    STDOUT.puts image["link"]
  end
end

output_urls
