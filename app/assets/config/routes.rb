Rails.application.routes.draw do
  get "/" => "home#top"
  get "/home/about" =>"home#about"
end