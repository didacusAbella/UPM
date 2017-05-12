class HomeController < ApplicationController
  get '/home' do
    @title = "Welcome"
    haml :home
  end

  get '/signin' do
    @title = "Signin"
    haml :signin
  end

  get '/signup' do
    @title = "Signup"
    haml :signup
  end
end