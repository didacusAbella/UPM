# Class that handles dashboard page. Inherits all methods from Application Controller
#
# See ApplicationController for more info
class DashboardController < ApplicationController
  helpers DashboardHelper
  get '/auth/home' do
    @title = "Dashboard"
    @name = self.class.current_user.name
    @last_name = self.class.current_user.last_name
    haml :'/pages/dashboard'
  end

  get '/auth/search' do
    @title = "Search"
    haml :'/pages/search'
  end

  get '/auth/patent/new' do
    @title = "Crea Nuovo Brevetto"
    haml :'/pages/new_patent'
  end

  get '/auth/logout' do
    logout(self.class.current_user.username)
    redirect "/"
  end

  post '/auth/patent/create_patent' do
    patent = create_patent(params, params[:image1], params[:image2], params[:image3])
    if patent
      send_file "contents/downloads/#{patent.title}.pdf", :filename => "#{patent.title}.pdf", :type => 'Application/octet-stream'
      redirect "/dashboard/auth/home"
      nil
    end
  end
end