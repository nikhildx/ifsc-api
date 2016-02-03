require 'sinatra'
require "sinatra/json"
require 'json'

get '/' do
  redirect 'http://ifsc.razorpay.com'
end

get '/:code' do
  begin
    code = params['code']
    bank = code[0...4]
    data = JSON.parse File.read "data/#{bank}.json"
    data = data[params['code']]
    json data if data
    status 404
    json "Not Found"
  rescue Exception => e
    status 404
    json "Not Found"
  end
end