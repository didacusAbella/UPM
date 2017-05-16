class HomeController < ApplicationController
  get '/home' do
    @title = "Welcome"
    haml :'/pages/home'
  end

  get '/signin' do
    @title = "Signin"
    haml :'/pages/signin'
  end

  get '/signup' do
    @title = "Signup"
    haml :'/pages/signup'
  end
end