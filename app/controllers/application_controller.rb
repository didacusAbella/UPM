class ApplicationController < Sinatra::Base

  set :root, File.expand_path('../../', __FILE__)
  set :environment, ENV['RACK_ENV']
  set :views, File.expand_path('../../views', __FILE__)
  set :haml, :format => :html5

  configure :development do
    puts "Now develop"
    enable :logging, :method_override, :dump_errors, :raise_errors,:show_exceptions, :static
  end

  configure :production do
    puts "Now production"
  end

  not_found do
    @title = "Oops!"
    haml :not_found
  end

  error 401 do
    haml :unauthorized
  end
end
