require 'sinatra'
require 'sinatra/contrib/all'
require 'sinatra/cors'


set :default_content_type, 'application/json'

set :allow_origin, "http://localhost:3000"
set :allow_methods, "GET,HEAD,POST"
set :allow_headers, "content-type,if-modified-since"
set :expose_headers, "location,link"

get "/" do
    '{"grid": [1,2,3,4,5,6,7,8,9]}'
end

#   options "*" do
#     response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
#     response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
#     response.headers["Access-Control-Allow-Origin"] = "http://localhost:3000"
#     200
#   end