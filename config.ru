require "chain"
require "sinatra/base"
require_relative "./app/controllers/application_controller"
Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }
map('/') { run HomeController }
map('/dashboard') { run DashController }