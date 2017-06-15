# Class that handles dashboard page. Inherits all methods from Application Controller
#
# See ApplicationController for more info
class DashboardController < ApplicationController
  helpers DashboardHelper

  get '/auth/home' do
    @title = "Dashboard"
    @name = self.class.current_user.name
    @last_name = self.class.current_user.last_name
    @user_patents = self.class.current_user.patents.select {|patent| patent.tags["deposited"] == false }
    haml :'/pages/dashboard'
  end


  get '/auth/logout' do
    logout(self.class.current_user.username)
    redirect "/"
  end

  get '/auth/deposit' do
    @alias = params[:patent]
    haml :'/pages/deposit'
  end

  get '/auth/patent' do
    @transactions = self.class.current_user.transactions.query(
      filter: "inputs(account_alias=$1) OR outputs(account_alias=$1)",
      filter_params: ['didacus'])
    haml :'/pages/transactions'
  end
end