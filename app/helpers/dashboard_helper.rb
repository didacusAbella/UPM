# DashboardHelper
# 
# This module contains helper methods for DashboardController
# See Sinatra::Base::Helper for more info about helpers
require 'digest'
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

  # call-seq:
  #   self.create_patent(params, *args) => Patent
  # This method create a new patent for a specific user and register it on the blockchain
  def create_patent(params, *args)
    #Create images from form submitted
    images = args.collect do |arg|
      File.open("contents/uploads/" + arg[:filename], "w") do |file|
       file.write(arg[:tempfile].read)
       file
      end
    end
    #Create an return patent object and pdf generations
    Patent.new(
      title: params[:title], 
      background: params[:background], 
      claims: params[:claims],
      summary: params[:summary], 
      description: params[:description],
      drawings: images
      ) do |created_patent|
        created_patent.to_pdf
        md5 = Digest::MD5.file "contents/downloads/#{created_patent.title}.pdf"
        created_patent.save!(self.class.current_user, md5.hexdigest)
        created_patent
    end
  end

end