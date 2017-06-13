# Controller for home page. Inherit all methods from Application Controller
#
# See ApplicationController for more info 
class HomeController < ApplicationController
  
  helpers HomeHelper

  get '/' do
    @title = "Welcome"
    @menu_entries = Home.new([{name: "About", link: "#about"}, {name: "Signin", link: "/signin"}, 
      {name: "Sign Up", link: "/signup"}, {name: "Contact", link: "#contact"}]).menu
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

  post '/register' do
    self.class.current_user = register_user(params)
    str = "name=#{self.class.current_user.name}&last_name=#{self.class.current_user.last_name}"
    redirect to("/dashboard/auth/home?#{str}") if self.class.current_user
  end

  post '/login' do
    self.class.current_user = login_user(params)
    str = "name=#{self.class.current_user.name}&last_name=#{self.class.current_user.last_name}"
    redirect to("/dashboard/auth/home?#{str}") if self.class.current_user
  end
end