# Class that handles dashboard page. Inherits all methods from Application Controller
#
# See ApplicationController for more info
class DashboardController < ApplicationController

  get '/auth/home' do
    #halt 401, haml(:unauthorized) if self.class.authenticate!
    @title = "Dashboard"
    @name = params['name']
    @last_name = params['last_name']
    haml :'/pages/dashboard'
  end

  get '/auth/search' do
    #halt 401, haml(:unauthorized) if self.class.authenticate!
    @title = "Search"
    haml :'/pages/search'
  end

  get '/auth/patent/new' do
    #halt 401, haml(:unauthorized) if self.class.authenticate!
    @title = "Crea Nuovo Brevetto"
    haml :'/pages/new_patent'
  end

  get '/auth/logout' do
    self.class.current_user.token = nil
    redirect to("home")
  end
end