# Main Controller. Handles setup configuration shared in other controllers
#
# See Documentation for Sinatra::Base for more information
class ApplicationController < Sinatra::Base

  set :root, File.expand_path('../../', __FILE__)
  set :environment, ENV['RACK_ENV']
  set :views, File.expand_path('../../views', __FILE__)
  set :haml, :format => :html5
  SIGNER = Chain::HSMSigner.new
  @@current_user = nil #Shared variable for manage session and token

  before do
    if request.path_info =~ /auth/
      #halt 401, haml(:unauthorized) if self.class.authenticate! 
    end
  end

  def self.current_user
    @@current_user
  end

  def self.current_user=(new_value)
    @@current_user = new_value
  end

  configure :development do
    puts "Now develop"
    enable :logging, :method_override, :dump_errors, :static, :raise_errors,:show_exceptions
  end

  configure :production do
    puts "Now production"
    disable :raise_error, :show_exceptions
  end

  not_found do
    @title = "Oops!"
    haml :not_found
  end

  error ValidationError do
    haml :validation_failed
  end

  error UnauthorizedError do
    haml :unauthorized
  end


  #This method check if the current user have the right permissions to access pages.
  #
  # call-seq:
  #   ApplicationController.authenticate! => TrueClass if token is valid FalseClass otherwise
  #
  # if FalseClass is returned the method block all redirect all request. See Sinatra::Base#redirect for more info 
  def self.authenticate!
    self.current_user.nil?
  end
end
