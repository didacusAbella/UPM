# HomeHelper
#
# This module contains helpers method for Home Controller
# See Sinatra::Base::Helper for more info about helpers
module HomeHelper

  def sync_data
    fn = -> (created_user, block_account) do
      created_user.username = block_account.alias
      created_user.name = block_account.tags["name"]
      created_user.last_name = block_account.tags["last_name"]
      created_user.password = block_account.tags["password"]
      created_user.find_patents
    end
    fn
  end
  
  # call-seq:
  #   self.register_user(params) => User
  # Create a new User and into chain with +params+ passed
  # +params+ => an Hash of values
  def register_user(params)
    User.new(params[:username]).save!(params, self.class::SIGNER, &sync_data)
  end

  #call-seq:
  #   self.login_user(params) => User
  # check if a user is in the system and log into dashboard
  # +params+ => Hash of values
  def login_user(params)
    User.new(params[:username]).find(params, &sync_data)
  end

  
end
