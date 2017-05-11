class ApplicationController < Sinatra::Base

  set :environment, ENV['RACK_ENV']
  set :views, File.expand_path('../../views', __FILE__)
  set :haml, :format => :html5

  configure :development do
    puts "Now develop"
    enable :logging, :method_override, :dump_errors, :raise_errors,:show_exceptions
  end

  configure :production do
    puts "Now production"
  end
end
