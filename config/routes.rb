Rails.application.routes.draw do
  get "/" => "links#new"
  post "/" => "links#create"
  get ":token" => "links#redirect"
  get ":token/info" => "links#info"
end
