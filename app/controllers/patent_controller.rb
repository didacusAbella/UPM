class PatentController < ApplicationController
  helpers PatentHelper

  get '/auth/search' do
    @title = "Search"
    haml :'/pages/search'
  end

  get '/auth/new_patent' do
    @title = "Crea Nuovo Brevetto"
    haml :'/pages/new_patent'
  end

  post '/auth/create_patent' do
    raise ValidationError, "params not valid retry. Into Create patent" if Validator.validate_params_patent(params)
    patent = create_patent(params, params[:image1], params[:image2], params[:image3])
    if patent
      send_file "contents/downloads/#{patent.title}.pdf", :filename => "#{patent.title}.pdf", :type => 'Application/octet-stream'
    end
  end

  post '/auth/deposit' do
    deposit_patent(params[:title][0...-4])
    @text = "Patent deposited with success"
    haml :success
  end

  post '/auth/search' do
    @search = search_patents(params[:search])
    haml :'/pages/search'
  end
end