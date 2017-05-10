class HomeController < ApplicationController
  
  get '/home' do
    haml :index
  end
end