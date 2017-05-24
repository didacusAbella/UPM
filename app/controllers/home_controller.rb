class HomeController < ApplicationController

  get '/home' do
    @title = "Welcome"
    @menu_entries = [
      {name: "About", link: "#about"}, 
      {name: "Signin", link: "/signin"}, 
      {name: "Sign Up", link: "/signup"},
      {name: "Contact", link: "#contact"}
    ]
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