require 'sinatra'
require 'sinatra/contrib/all'

get "/" do
    headers 'Access-Control-Allow-Origin' => "http://localhost:3000"
    '{"grid": [1,2,3,4,5,6,7,8,9]}'
end