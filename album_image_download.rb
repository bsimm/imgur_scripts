#!/usr/bin/env ruby
require 'net/http'
require 'net/https'
require 'open-uri'
require 'json'

def imgur_data
  headers = { "Authorization" => "Client-ID YOUR_CLIENT_ID"}
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

def url_array
  [].tap do |array|
    images.each do |image|
      array << image["link"]
    end
  end
end

def download
  url_array.each do |url|
    filename = /(\w+).jpg/.match(url)[0]
    File.write("/destination/path/#{filename}", open(url).read, {mode: "wb"})
  end
end

download
