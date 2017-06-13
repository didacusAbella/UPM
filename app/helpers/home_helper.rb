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
    end
    fn
  end
  
  # call-seq:
  #   self.register_user(params) => User
  # Create a new User and into chain with +params+ passed
  # +params+ => an Hash of values
  def register_user(params)
    User.new(params[:username]).save!(params, &sync_data)
  end

  def login_user(params)
    User.new(params[:username]).find(params, &sync_data)
  end

  
end
