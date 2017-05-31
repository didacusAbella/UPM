class HomeController < ApplicationController
  helpers ApplicationHelper

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

  post '/register' do
    #signer.add_key(key, chain.mock_hsm.signer_conn)
      chain.accounts.create(
      alias: params[:username],
      root_xpubs: [key.xpub],
      quorum: 1,
      tags: {
        first_name: params[:name],
        last_name: params[:last_name]
      }
    )
    redirect "/dashboard/home"
  end
end