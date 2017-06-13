#Require Vendor Library
require "chain"
require "sinatra/base"
require "prawn"
#Require My files
#require_relative "./app/controllers/application_controller"
Dir['./app/models/*.rb'].each{ |file| require file }
Dir['./app/helpers/*.rb'].each {|file| require file }
(Dir['./app/controllers/*.rb']).sort.each { |file| require file }
map('/') { run HomeController }
map('/dashboard') { run DashboardController }
