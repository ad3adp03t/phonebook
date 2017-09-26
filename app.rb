require 'sinatra'
require_relative 'functions.rb'
enable :sessions


get '/' do
    erb :index
end

post '/handle_submission' do


    session[:firstnm] = params[:firstnm]
    session[:lastnm] = params[:lastnm]
    session[:streetnm] = params[:streetnm]
    session[:zip_cty_st] = params[:zip_cty_st]
    session[:phone] = params[:phone]
    session[:email] = params[:email]


    insert_contact(session[:firstnm],
        session[:lastnm],
        session[:streetnm],
        session[:zip_cty_st],
        session[:phone],
        session[:email]
        )


    redirect :show_submission

end

get '/show_submission' do
    erb :show_submission 
end

get '/show_all_contacts' do
    erb :show_all_contacts
end

post '/handle_update' do
    update_contact(params[:firstnm],
    params[:lastnm],
    params[:streetnm],
    params[:zip_cty_st],
    params[:phone],
    params[:email],
    params[:id])

    redirect :show_all_contacts
end

get '/search_contacts' do
    erb :search_contacts
end

post '/search_contacts' do
    @params = params
    full_search_table_render(@params)
end
