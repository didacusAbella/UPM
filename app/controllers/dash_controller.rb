class DashController < ApplicationController

  get '/home' do
    @title = "Dashboard"
    haml :'/pages/dashboard'
  end

  get '/search' do
    @title = "Search"
    haml :'/pages/search'
  end
end