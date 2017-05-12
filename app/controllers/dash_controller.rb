class DashController < ApplicationController

  get '/home' do
    @title = "Dashboard"
    haml :main
  end
end