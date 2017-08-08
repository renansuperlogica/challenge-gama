# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'httparty'

get '/' do
  endereco = params['url']
  if endereco && endereco != ""
  endereco = params['url'].gsub(' ', '+')

  escaped  = URI.escape(endereco)
  url      = "http://maps.google.com/maps/api/geocode/json?address=#{escaped}"
  response = HTTParty.get(url)
  parsed   = JSON.parse(response.body)['results']
  else
    parsed = ""
end
  
  erb :index, :locals => {result: parsed}
end
