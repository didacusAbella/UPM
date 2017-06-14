# DashboardHelper
# 
# This module contains helper methods for DashboardController
# See Sinatra::Base::Helper for more info about helpers

module DashboardHelper

  # call-seq:
  #   self.logout(username) => Undefined Value
  # This method logout the client from the system.
  def logout(id)
    LocalChain.instance.authorization_grants.delete({
      guard_type: 'access_token',
      guard_data: { id: id }
    })
    LocalChain.instance.access_tokens.delete(id)
    self.class.current_user = nil
  end
end